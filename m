Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC31C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 16 May 2022 15:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245337AbiEPPhI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 May 2022 11:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243266AbiEPPhH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 May 2022 11:37:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785D4245AF
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 08:37:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C6BA60F63
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 15:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E205C385AA;
        Mon, 16 May 2022 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652715425;
        bh=NpkAA1EIvx/U3gbWNsWpac0XszNDfanqQTRUpf08P74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cJInKloHuUjyXwS+mavQ7MoqGL8JXAhLnn3Vyo+BCh1C2HAH8Ubrw8drRywa7UVuS
         Vt0NdUMWaH9EboDmIN5Bj9N3KycQjnaGC8m7EEiolK6x8aTxVVQp4WvPtIPJoKArPh
         jKFwKu20pFoRy63pCYzWT+hcJ+RfipBtkdXrNZohEaHIivgw53yy9rrnMCPB1z3SKl
         jLGR3wcoqp5BzHuUova9O1SovldUanjAM+oWATSELLp4Dctglun1NE7C5MXb0tEmqC
         xQLH+BtZopx+lAsPCj3+HlP6T2dmGl2hwfRIH5OQGzWmS2rWnXGIWocR+s1NcnhE0d
         t6OPl4KzxBIWg==
Date:   Mon, 16 May 2022 08:37:04 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/4] xfs/148: fix failure from bad shortform size
 assumptions
Message-ID: <YoJvoETVVzsIHmvQ@magnolia>
References: <20220516085922.1306879-1-david@fromorbit.com>
 <20220516085922.1306879-4-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516085922.1306879-4-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 16, 2022 at 06:59:21PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> We replaced an attr named:
> 
> slashstr="are_bad_for_you"
> 
> with this substitution:
> 
> cp $imgfile $imgfile.old
> sed -b \
>         -e "s/$nullstr/too_many\x00beans/g" \
>         -e "s/$slashstr/are_bad\/for_you/g" \
>         -i $imgfile
> 
> We then try to retreive the attr named 'a_are_bad/for_you'. The
> failure is:
> 
>     -Attribute "a_are_bad/for_you" had a 3 byte value for TEST_DIR/mount-148/testfile:
>     -heh
>     +attr_get: No data available
>     +Could not get "a_are_bad/for_you" for TEST_DIR/mount-148/testfile
> 
> The error returned is ENODATA - the xattr does not exist. While the
> name might exist in the attr leaf block:
> 
> ....
> nvlist[0].valuelen = 3
> nvlist[0].namelen = 17
> nvlist[0].name = "a_are_bad/for_you"
> nvlist[0].value = "heh"
> nvlist[1].valuelen = 3
> ....
> 
> xattrs are not looked up by name matches when in leaf or node form
> like they are in short form.  They are looked up by *name hash*
> matches, and if the hash is not found, then the name does not exist.
> Only if the has match is found, then it goes and retrieves the xattr
> pointed to by the hash and checks the name.
> 
> At this point, it should be obvious that the hash of
> "a_are_bad_for_you" is different to "a_a_are_bad/for_you". Hence the
> leaf lookup is always rejected at the hash match stage and never
> gets to the name compare stage.
> 
> IOWs, this test can *never* pass when the xattr is in leaf/node
> form, only when it is in short form.
> 
> The reason the attr fork is in leaf form is that we are using
> "-m crc=0" and so the inodes are only 256 bytes in size and can only
> hold ~150 bytes in the literal area. That leaves ~100 bytes maximum
> for shortform attr data. The test consumes ~80 bytes of shortform
> space, so it should fit and the test pass.
> 
> However:
> 
> nvlist[4].valuelen = 37
> nvlist[4].namelen = 7
> nvlist[4].name = "selinux"
> nvlist[4].value = "unconfined_u:object_r:unlabeled_t:s0\000"
> 
> Yes, I run the fstests with selinux enabled on some of test
> machines. The selinux attr pushes the attr fork way over the size
> that can fit in the shortform literal area, and so it moves to leaf
> form as the attrs are initially added and the test fails.
> 
> Fix this by forcing the test to use 512 byte inodes, so as to
> provide around 350 bytes of usable attr fork literal area so it's
> not affected by security attributes.

I've long wondered if I should patch in a "security" module that
automatically pastes in a fake "s3linux" attribute so that I can
experience the different fs behavior that y'all see.

> While there, clean up the silly conditional loop device cleanup
> code.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/xfs/148 | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/xfs/148 b/tests/xfs/148
> index 8d50a642..5d0a0bf4 100755
> --- a/tests/xfs/148
> +++ b/tests/xfs/148
> @@ -15,7 +15,7 @@ _cleanup()
>  {
>  	cd /
>  	$UMOUNT_PROG $mntpt > /dev/null 2>&1
> -	test -n "$loopdev" && _destroy_loop_device $loopdev > /dev/null 2>&1
> +	_destroy_loop_device $loopdev > /dev/null 2>&1
>  	rm -r -f $tmp.*
>  }
>  
> @@ -41,9 +41,12 @@ test_names=("something" "$nullstr" "$slashstr" "another")
>  rm -f $imgfile $imgfile.old
>  
>  # Format image file w/o crcs so we can sed the image file
> +# We need to use 512 byte inodes to ensure the attr forks remain in short form
> +# even when security xattrs are present so we are always doing name matches on
> +# lookup and not name hash compares as leaf/node forms will do.
>  $XFS_IO_PROG -f -c 'truncate 40m' $imgfile
>  loopdev=$(_create_loop_device $imgfile)
> -MKFS_OPTIONS="-m crc=0" _mkfs_dev $loopdev >> $seqres.full
> +MKFS_OPTIONS="-m crc=0 -i size=512" _mkfs_dev $loopdev >> $seqres.full
>  
>  # Mount image file
>  mkdir -p $mntpt
> @@ -121,9 +124,6 @@ res=$?
>  test $res -eq 1 || \
>  	echo "repair failed to report corruption ($res)"
>  
> -_destroy_loop_device $loopdev
> -loopdev=
> -
>  # success, all done
>  status=0
>  exit
> -- 
> 2.35.1
> 
