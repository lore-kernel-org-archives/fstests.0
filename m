Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D9AC83F16
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Aug 2023 14:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjH1OQi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Aug 2023 10:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjH1OQP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Aug 2023 10:16:15 -0400
Received: from sandeen.net (sandeen.net [63.231.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C506110B
        for <fstests@vger.kernel.org>; Mon, 28 Aug 2023 07:16:12 -0700 (PDT)
Received: from [10.0.0.71] (liberator.sandeen.net [10.0.0.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id C457251B58C;
        Mon, 28 Aug 2023 09:16:11 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net C457251B58C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
        s=default; t=1693232171;
        bh=hjew/CS/pGpPtSLkCzFOaUKOq6jX7ctlTrbUlmu1ifc=;
        h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
        b=aJjNRgrotAklF3MiZlIYAmK317d9srHuN0mILEY2JjC72Xl5pLqW+3YUwH87VEj1C
         ckO4tQBvmLGIKDroSseTY6tBnhMdEG65cs3Ocw3+ZXigAy4mwYUtdDwjQC5+n7OMl4
         3Wt8NsOA2tQRHYtvdoNLeGwizI8g0TFjbxqLBx7mTzrSlYttuBNJ/oZKOinBQcHgUh
         4ro8e+F2oIaSw6REGZi4rYEmvyMTijGXHd6Ij9a/eFU6fSBW62gI+xS9ws5MnIJpcD
         u2BBwVCe5WtZhXBXxrexVsozh489gjq5WyI3bmBLD1xWmisnyqlSsdlHdcSPbJMUgJ
         85OVZYnoCtazQ==
Message-ID: <4d035b07-784c-320c-ca7a-753ae0a81b6b@sandeen.net>
Date:   Mon, 28 Aug 2023 09:16:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2] fstests: generic/352 should accomodate other pwrite
 behaviors
Content-Language: en-US
To:     Bill O'Donnell <bodonnel@redhat.com>, fstests@vger.kernel.org
References: <20230825200906.95973-1-bodonnel@redhat.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>
From:   Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20230825200906.95973-1-bodonnel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 8/25/23 3:09 PM, Bill O'Donnell wrote:
> xfs_io pwrite issues a series of block size writes, but there is no guarantee
> that the resulting extent(s) will be singular or contiguous. This behavior is
> acceptable, but the test is flawed in that it expects a single extent for a
> pwrite.
> 
> Modify test to accept any layout for the reflinked logical range.

I think this is no longer what the change does, right? You've now
changed it so that it only pwrites (and reflinks) a single block rather
than multiple, to avoid dealing with fragmentation issues.

> 
> Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> ---
>  tests/generic/352     | 9 +++++----
>  tests/generic/352.out | 6 ++----
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/generic/352 b/tests/generic/352
> index 52ec4850..77570bce 100755
> --- a/tests/generic/352
> +++ b/tests/generic/352
> @@ -28,14 +28,15 @@ _require_xfs_io_command "fiemap"
>  _scratch_mkfs > /dev/null 2>&1
>  _scratch_mount
>  
> -blocksize=$((128 * 1024))
> +blocksize=$(_get_file_block_size $SCRATCH_MNT)
>  _require_congruent_file_oplen $SCRATCH_MNT $blocksize
>  file="$SCRATCH_MNT/tmp"
>  
>  # Golden output is for $LOAD_FACTOR == 1 case

$LOAD_FACTOR == 1 and 4k block size case, now - this is a little tricky
so worth documenting IMHO.

>  orig_nr=8192
> -orig_last_extent=$(($orig_nr * $blocksize / 512))
> -orig_end=$(($orig_last_extent + $blocksize / 512 - 1))
> +orig_blocksize=4096
> +orig_last_extent=$(($orig_nr * $orig_blocksize / 512))
> +orig_end=$(($orig_last_extent + $orig_blocksize / 512 - 1))
>  
>  # Real output
>  nr=$(($orig_nr * $LOAD_FACTOR))
> @@ -43,7 +44,7 @@ last_extent=$(($nr * $blocksize / 512))
>  end=$(($last_extent + $blocksize / 512 - 1))
>  
>  # write the initial block for later reflink
> -_pwrite_byte 0xcdcdcdcd 0 $blocksize $file | _filter_xfs_io
> +_pwrite_byte 0xcdcdcdcd 0 $blocksize $file | _filter_xfs_io > /dev/null

I think it's fine to exclude the non-matching lines of xfs_io output,
but there's no reason to run it through the filter if you send it all to
/dev/null anyway, so could just drop the filter here.

Other than those nitpicks, I think this looks fine now.

-Eric

>  
>  # use reflink to create the rest of the file, whose all extents are all
>  # pointing to the first extent
> diff --git a/tests/generic/352.out b/tests/generic/352.out
> index 4ff66c21..454ff52f 100644
> --- a/tests/generic/352.out
> +++ b/tests/generic/352.out
> @@ -1,5 +1,3 @@
>  QA output created by 352
> -wrote 131072/131072 bytes at offset 0
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -0: [0..2097151]: shared
> -1: [2097152..2097407]: shared|last
> +0: [0..65535]: shared
> +1: [65536..65543]: shared|last

