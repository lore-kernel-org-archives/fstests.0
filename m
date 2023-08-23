Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE9DEE4993
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Aug 2023 16:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbjHWQqp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Aug 2023 12:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjHWQqp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Aug 2023 12:46:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B7011F
        for <fstests@vger.kernel.org>; Wed, 23 Aug 2023 09:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9F7961DD0
        for <fstests@vger.kernel.org>; Wed, 23 Aug 2023 16:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD465C433C8;
        Wed, 23 Aug 2023 16:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692809201;
        bh=YzDVs4BzHI1cvM1kwQYI6EeSkRM2rkEFH3HAcyRmSLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ObDaIVDFCV4GP6lHrPb+ghOE4vNC9Ow9ODNByqgOCPeDCW1M9ecDDlGpCPhfNVtWo
         GTT3hKegMrh8Xd0Rz/hgxnn83p7jK8KGU6x+cwKDgcTSGzmbs8qOMQMYxFbNTnmxSv
         gyX1E3c7x/eUS+mh/Aw2lUXDyCWamdnyF0ArbUrtbuKPESOJez8prEdCxRsu9xn6vA
         nze1u3JKnWMbn7B7aPMuhBndtLco9d50e6KUEaeREdl02+HyYG2wFLPgqlyVw2SI8/
         YmTRCz5pvPT/JZZeFrIlX7FSoXdqur47j+wOnjdINl5sl9r7k9y61GzpPcOl8E4K7K
         aFeW9PxxVJ6VA==
Date:   Wed, 23 Aug 2023 09:46:41 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Bill O'Donnell <bodonnel@redhat.com>
Cc:     fstests@vger.kernel.org, quwenruo@cn.fujitsu.com
Subject: Re: [PATCH] fstests: generic/352 should accomodate other pwrite
 behaviors
Message-ID: <20230823164641.GA11251@frogsfrogsfrogs>
References: <20230823154350.18829-1-bodonnel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823154350.18829-1-bodonnel@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Aug 23, 2023 at 10:43:50AM -0500, Bill O'Donnell wrote:
> xfs_io pwrite issues a series of block size writes, but there is no guarantee
> that the resulting extent(s) will be singular or contiguous. This behavior is
> acceptable, but the test is flawed in that it expects a single extent for a
> pwrite.
> 
> Modify test to accept any layout for the reflinked logical range.
> 
> Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> ---
>  tests/generic/352     | 16 +++++++++++-----
>  tests/generic/352.out |  2 --
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/generic/352 b/tests/generic/352
> index 52ec4850..c4ee8a44 100755
> --- a/tests/generic/352
> +++ b/tests/generic/352
> @@ -48,19 +48,25 @@ _pwrite_byte 0xcdcdcdcd 0 $blocksize $file | _filter_xfs_io
>  # use reflink to create the rest of the file, whose all extents are all
>  # pointing to the first extent
>  for i in $(seq 1 $nr); do
> -	_reflink_range $file 0 $file $(($i * $blocksize)) $blocksize > /dev/null
> +	_reflink_range $file 0 $file $(($i * $blocksize)) $blocksize > $tmp1.out

$tmp1 isnt defined anywhere.

>  done
>  
>  # then call fiemap on that file to test both the shared flag and if
>  # reserved extent mapping search will cause soft lockup
> -$XFS_IO_PROG -c "fiemap -v" $file | _filter_fiemap_flags > $tmp.out
> -cat $tmp.out >> $seqres.full
> +$XFS_IO_PROG -c "fiemap -v" $file | _filter_fiemap_flags > $tmp2.out
> +cat $tmp2.out >> $seqres.full

Nor is $tmp2

>  
>  # refact the $LOAD_FACTOR to 1 to match the golden output
>  sed -i -e "s/$(($last_extent - 1))/$(($orig_last_extent - 1))/" \
>  	-e "s/$last_extent/$orig_last_extent/" \
> -	-e "s/$end/$orig_end/" $tmp.out
> -cat $tmp.out
> +	-e "s/$end/$orig_end/" $tmp2.out
> +
> +cat $tmp1.out > tmp.1
> +cat $tmp2.out > tmp.2

Not sure why you didn't make the _reflink_range and the fiemap above
output to $tmp.out1 and $tmp.out2, respectively.  If you had, then the
default _cleanup would delete $tmp.* automatically...

> +
> +diff tmp.[12]
> +rm tmp.1
> +rm tmp.2

...and the rm here wouldn't be necessary.

Ok.  Nitpicking over.  Moving on to the weirder design questions of the
original test:

[add original test author to cc]

I don't know why $blocksize is set to 128k above.  If this test needs to
guarantee that there would only be *one* extent (and the golden output
implies this as you note), then it should have been written to say:

	blocksize=$(_get_file_block_size $SCRATCH_MNT)

But I don't know if the "btrfs soft lock up and return wrong shared
flag" behavior required sharing a (probably multi-block) 128k range, or
if that was simply what the author selected because it reproduced the
problem.

>  
>  # success, all done
>  status=0
> diff --git a/tests/generic/352.out b/tests/generic/352.out
> index 4ff66c21..ad90ae0d 100644
> --- a/tests/generic/352.out
> +++ b/tests/generic/352.out
> @@ -1,5 +1,3 @@
>  QA output created by 352
>  wrote 131072/131072 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -0: [0..2097151]: shared
> -1: [2097152..2097407]: shared|last

Also I suspect from the test description that the goal here was to
detect the golden output failing because the shared flag does not get
reported correctly.

--D
> -- 
> 2.41.0
> 
