Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A190C54E76
	for <linux-fstests@archiver.kernel.org>; Fri,  6 Jan 2023 07:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjAFH7m (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 6 Jan 2023 02:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjAFH7h (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 6 Jan 2023 02:59:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B243578E83
        for <fstests@vger.kernel.org>; Thu,  5 Jan 2023 23:59:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AFF6B81C6B
        for <fstests@vger.kernel.org>; Fri,  6 Jan 2023 07:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CC3C433EF;
        Fri,  6 Jan 2023 07:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672991972;
        bh=TE3FVuvbpPNqo0D+wtkm29LrkrazFIGgvAhFDyOx/pY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J21lyC2KRrUfzAWalIwDdIzWu4fPMNFz6wYwxP6Z0EEj4WOd+GRwMtDllktA8nY19
         6+X1s2SBf/PaLclmwX9klwJROZfz+unOh2trLPlhrFJ4ayjL6TcFdnrk3XIt803N7a
         JosmIIX2WQwCdTMfzWmhvFTTu4ksp77XNW1I71OFNY3rMbd9S5tKeXQ0ktybllcIFp
         6IXi7LqI8A6VOAKstoGccVHDvZRbH8g3biRaBD95uAT13cPjw0nlMyEuIl4CL0nPnf
         DKrLBRzJlp4gfYgNknAVFqG56+qe4hqZNA1MzVH1cFd27uBfknDBzSn71iZXSOZCYP
         YVXw+sNHSPpNA==
Date:   Thu, 5 Jan 2023 23:59:30 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     bxue@redhat.com
Cc:     fstests@vger.kernel.org, lczerner@redhat.com
Subject: Re: [PATCH v1] src/stat_test.c: add STATX_DIOALIGN support
Message-ID: <Y7fU4pRA+LHhsMKj@sol.localdomain>
References: <20230104042801.217898-1-bxue@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104042801.217898-1-bxue@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Boyang,

On Wed, Jan 04, 2023 at 12:28:01PM +0800, bxue@redhat.com wrote:
> From: Boyang Xue <bxue@redhat.com>
> 
> Signed-off-by: Boyang Xue <bxue@redhat.com>
> ---
> Hi,
> 
> The latest kernel has support for exposing direct I/O alignment
> information via statx() by
> 
> 825cf206ed51 statx: add direct I/O alignment information
> 
> I'm trying to enhance xfstests/src/stat_test.c to support this
> functionality, and the final goal is enhancing generic/423 to test it.
> 
> I think I have made all the necessary change here, but it always prints
> stx_dio_mem_align and stx_dio_offset_align as 0 (should be 512)
> 
> [root@localhost repo_xfstests-dev]# src/stat_test -v
> ../testfile stx_dio_offset_align=222
>  - call statx ../testfile
>  - call stat ../testfile
>  - compare statx and stat
>  - begin time 0.000000000
>  -      btime 1672804449.041990601
>  -      atime 1672804449.041990601
>  -      mtime 1672804449.127990601
>  -      ctime 1672804449.127990601
>  - check stx_dio_offset_align=222
> [!] stx_dio_offset_align differs, 0 != 222
> Failed
> 
>  src/stat_test.c | 10 ++++++++++
>  src/statx.h     | 10 ++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> The kernel version in test is kernel-6.2.0-0.rc1.
> 
> Could you suggest how to fix it please?
> 
> Thanks,
> Boyang

Thanks for working on this!  One of the challenges with testing STATX_DIOALIGN
is that it can only be usefully tested if DIO is supported, yet STATX_DIOALIGN
is itself the way to check whether DIO is supported.  Another challenge is that
without something to compare the alignments against, it's hard to know whether
the correct values are being reported.  (A test could try to validate the values
by attempting DIO, but the filesystem might fall back to buffered I/O for
unsupported or misaligned DIO, which would be hard to distinguish from true DIO.
Maybe something clever could be done with mincore() detect buffered I/O.)

Is there a specific test that you're planning to add?  A test that would be at
least somewhat useful would be to test that if STATX_DIOALIGN gives nonzero
stx_dio_mem_align and stx_dio_offset_align, then DIO aligned to *only* those
alignments doesn't return an error.

Another possible test would to find a specific case where the DIO support and
alignments can be determined by another method and compared to what
STATX_DIOALIGN reports.  For example, if testing XFS, the XFS_IOC_DIOINFO ioctl
can be used.  Or if the test just creates a filesystem with the default options
and mounts it with the default options, it might just "know" that DIO is
supported with logical_block_size alignment.

Anyway, as for why your patch to stat_test.c doesn't work, it's because there's
a bug in it.  Try the following:

diff --git a/src/stat_test.c b/src/stat_test.c
index cd38a54a..85d703a0 100644
--- a/src/stat_test.c
+++ b/src/stat_test.c
@@ -570,6 +570,8 @@ static void check_field(const struct statx *stx, char *arg)
 	case stx_rdev_minor:
 	case stx_dev_major:
 	case stx_dev_minor:
+	case stx_dio_mem_align:
+	case stx_dio_offset_align:
 		ucheck = strtoull(val, &p, 0);
 		if (*p)
 			bad_arg("Field '%s' requires unsigned integer\n", key);
@@ -577,8 +579,6 @@ static void check_field(const struct statx *stx, char *arg)
 		      "%s differs, %llu != %llu\n", key, uval, ucheck);
 		break;
 
-	case stx_dio_mem_align:
-	case stx_dio_offset_align:
 	case stx_atime_tv_sec:
 	case stx_atime_tv_nsec:
 	case stx_btime_tv_sec:
