Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CC1C433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  7 Jul 2022 12:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiGGMG6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 7 Jul 2022 08:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiGGMG5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Jul 2022 08:06:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3E9359250
        for <fstests@vger.kernel.org>; Thu,  7 Jul 2022 05:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657195616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cswp1W4fDYbRNUlZoZszqB2eX9A/PZasT/enQjGr+k8=;
        b=NnEd2X6gcdY7/jYAPzARyIZjyLr1eeCNG6Lg23pFLDk8Djz/tVYujFhl9EiF0ZusQ0M5AM
        maKHmnP/Fefd84cphWnBfuL4U0prZrii0Ppt4COXvMG++4UzLSmd5GZV/A4A9NCAYUbdMW
        gnp9JpqWh/x3mdmIPmRwKDlEbH6WzUE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-Al9Gl3SVNW2dZ2eAJa-GtQ-1; Thu, 07 Jul 2022 08:06:47 -0400
X-MC-Unique: Al9Gl3SVNW2dZ2eAJa-GtQ-1
Received: by mail-qt1-f198.google.com with SMTP id j29-20020ac8405d000000b0031e9bb077dfso995497qtl.15
        for <fstests@vger.kernel.org>; Thu, 07 Jul 2022 05:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cswp1W4fDYbRNUlZoZszqB2eX9A/PZasT/enQjGr+k8=;
        b=h8HY1iq5/aV+n+TKx2A1izzT2q/EU7YY99CPyPcvDTWZ0v3O6zYJH8Fo+yvfW6dzhF
         stKjQMx1whIyTwwnF+wOokXgzug5kXcRACOWFIAYq/dUg/mn/sLnm/lfQdDu54D8S3TW
         xd1eKQcRani8B0ktizvASsLhbuGsYzTdDzzYZdN9tA0zNrySK7ya8FzVmA0BpY/JzwMZ
         QuILhWX8byW5JcH9k0jTDnhWZht3MkYqQiudh+PFqlUpX37nPGSxOxtSEIwX8bMEFejx
         FTWD2Z4xvlOiVeAje71HfyQw/Fe4r8FTZOk3IHQrwP8eRrAwdoitG4QUgg9q0rvtLbuG
         Brlg==
X-Gm-Message-State: AJIora9RdEARgWTSOdkijjdvY61/cIZ1MTpkeDCOz4kbEID4sY1LPWu5
        KetN9Ey4DVYHiSDXbzL15R7/qr08IPKvFRZ1l7zzniGQO0TCH11dXtvwqFUZGJKN+lI+c2eWNL+
        dmRIovUk9lC8fbYsE7g==
X-Received: by 2002:a05:6214:1d2b:b0:473:2501:4575 with SMTP id f11-20020a0562141d2b00b0047325014575mr5101143qvd.42.1657195606344;
        Thu, 07 Jul 2022 05:06:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1st/Ok4H9m0+N4my01qIwS+qvaYwvLYupAjqebU2UxpEFc8P+ijJrLmM0Wc2ukzrSkLQD3ikQ==
X-Received: by 2002:a05:6214:1d2b:b0:473:2501:4575 with SMTP id f11-20020a0562141d2b00b0047325014575mr5101078qvd.42.1657195605584;
        Thu, 07 Jul 2022 05:06:45 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c13-20020a05620a164d00b006a6a4b43c01sm30101671qko.38.2022.07.07.05.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 05:06:45 -0700 (PDT)
Date:   Thu, 7 Jul 2022 20:06:39 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] xfs: make sure that we handle empty xattr leaf
 blocks ok
Message-ID: <20220707120639.qoqsfcwtmdyl5duv@zlang-mailbox>
References: <165705854325.2821854.10317059026052442189.stgit@magnolia>
 <165705854877.2821854.7070105861462675249.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165705854877.2821854.7070105861462675249.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 05, 2022 at 03:02:28PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Make sure that the kernel can handle empty xattr leaf blocks properly,
> since we've screwed this up enough times.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/845 |  131 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100755 tests/xfs/845
> 
> 
> diff --git a/tests/xfs/845 b/tests/xfs/845
> new file mode 100755
> index 00000000..4a846e57
> --- /dev/null
> +++ b/tests/xfs/845
> @@ -0,0 +1,131 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 845
> +#
> +# Make sure that XFS can handle empty leaf xattr blocks correctly.  These
> +# blocks can appear in files as a result of system crashes in the middle of
> +# xattr operations, which means that we /must/ handle them gracefully.
> +# Check that read and write verifiers won't trip, that the get/list/setxattr
> +# operations don't stumble over them, and that xfs_repair will offer to remove
> +# the entire xattr fork if the root xattr leaf block is empty.
> +#
> +# Regression test for kernel commit:
> +#
> +# af866926d865 ("xfs: empty xattr leaf header blocks are not corruption")
> +#
> +. ./common/preamble
> +_begin_fstest auto quick attr
> +
> +# Override the default cleanup function.
> +# _cleanup()
> +# {
> +# 	cd /
> +# 	rm -r -f $tmp.*
> +# }

Remove this part directly?

> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/attr
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
      ^^
      This comment is useless

> +_supported_fs xfs
> +_require_scratch
> +_fixed_by_kernel_commit af866926d865 "xfs: empty xattr leaf header blocks are not corruption"
> +
> +_scratch_mkfs_xfs | _filter_mkfs >$seqres.full 2>$tmp.mkfs
> +cat $tmp.mkfs >> $seqres.full
> +source $tmp.mkfs
> +_scratch_mount
> +
> +$XFS_IO_PROG -f -c 'pwrite -S 0x58 0 64k' $SCRATCH_MNT/largefile >> $seqres.full
> +$XFS_IO_PROG -f -c "pwrite -S 0x58 0 $isize" $SCRATCH_MNT/smallfile >> $seqres.full
> +
> +smallfile_md5=$(md5sum < $SCRATCH_MNT/smallfile)
> +largefile_md5=$(md5sum < $SCRATCH_MNT/largefile)

Hmm... is the tail '-' (printed by md5sum) as you wish? How about use the
_md5_checksum() in common/rc ? (Same as below small_md5 and large_md5 part)

> +
> +# Try to force the creation of a single leaf block in each of three files.
> +# The first one gets a local attr, the second a remote attr, and the third
> +# is left for scrub and repair to find.
> +touch $SCRATCH_MNT/e0
> +touch $SCRATCH_MNT/e1
> +touch $SCRATCH_MNT/e2
> +
> +$ATTR_PROG -s x $SCRATCH_MNT/e0 < $SCRATCH_MNT/smallfile >> $seqres.full
> +$ATTR_PROG -s x $SCRATCH_MNT/e1 < $SCRATCH_MNT/smallfile >> $seqres.full
> +$ATTR_PROG -s x $SCRATCH_MNT/e2 < $SCRATCH_MNT/smallfile >> $seqres.full
> +
> +e0_ino=$(stat -c '%i' $SCRATCH_MNT/e0)
> +e1_ino=$(stat -c '%i' $SCRATCH_MNT/e1)
> +e2_ino=$(stat -c '%i' $SCRATCH_MNT/e2)
> +
> +_scratch_unmount
> +
> +# We used to think that it wasn't possible for empty xattr leaf blocks to
> +# exist, but it turns out that setting a large xattr on a file that has no
> +# xattrs can race with a log flush and crash, which results in an empty
> +# leaf block being logged and recovered.  This is rather hard to trip, so we
> +# use xfs_db to turn a regular leaf block into an empty one.
> +make_empty_leaf() {
> +	local inum="$1"
> +
> +	echo "editing inode $inum" >> $seqres.full
> +
> +	magic=$(_scratch_xfs_get_metadata_field hdr.info.magic "inode $inum" "ablock 0")
> +	if [ "$magic" = "0xfbee" ]; then
> +		_notrun "V4 filesystems deprecated"

Can _require_scratch_xfs_crc (at beginning) help that? Or is there a way to
get a v4 leaf block when crc isn't enabled?

> +		return 1

I think _notrun will exit directly, this "return 1" never be run.

> +	fi
> +
> +	magic=$(_scratch_xfs_get_metadata_field hdr.info.hdr.magic "inode $inum" "ablock 0")
> +	if [ "$magic" != "0x3bee" ]; then
> +		echo "inode $inum ablock 0 is not a leaf block?"
> +		_scratch_xfs_db -x -c "inode $inum" -c "ablock 0" -c print >> $seqres.full
> +		return 1
> +	fi
> +
> +	base=$(_scratch_xfs_get_metadata_field "hdr.freemap[0].base" "inode $inum" "ablock 0")
> +
> +	_scratch_xfs_db -x -c "inode $inum" -c "ablock 0" \
> +		-c "write -d hdr.count 0" \
> +		-c "write -d hdr.usedbytes 0" \
> +		-c "write -d hdr.firstused $dbsize" \
> +		-c "write -d hdr.freemap[0].size $((dbsize - base))" \

Nice trick:) Do we expect there's not corruption (can be found by xfs_repair)
at here? Or xfs_repair should blame the empty leaf block?

> +		-c print >> $seqres.full
> +}
> +
> +make_empty_leaf $e0_ino || exit

How about call _fail() directly in make_empty_leaf, if [ "$magic" != "0x3bee" ]

> +make_empty_leaf $e1_ino
> +make_empty_leaf $e2_ino
> +
> +_scratch_mount
> +
> +# Check that listxattr/getxattr/removexattr do nothing.
> +$ATTR_PROG -l $SCRATCH_MNT/e0 2>&1 | _filter_scratch
> +$ATTR_PROG -g x $SCRATCH_MNT/e0 2>&1 | _filter_scratch
> +$ATTR_PROG -r x $SCRATCH_MNT/e0 2>&1 | _filter_scratch
> +
> +# Add a small attr to e0
> +$ATTR_PROG -s x $SCRATCH_MNT/e0 < $SCRATCH_MNT/smallfile > /dev/null
> +$ATTR_PROG -l $SCRATCH_MNT/e0 2>&1 | sed -e 's/\([0-9]*\) byte/XXX byte/g' | _filter_scratch
> +small_md5="$($GETFATTR_PROG -n user.x --absolute-names --only-values $SCRATCH_MNT/e0 | md5sum)"
> +test "$small_md5" = "$smallfile_md5" || \
> +	echo "smallfile $smallfile_md5 does not match small attr $small_md5"
> +
> +# Add a large attr to e1
> +$ATTR_PROG -s x $SCRATCH_MNT/e1 < $SCRATCH_MNT/largefile > /dev/null
> +$ATTR_PROG -l $SCRATCH_MNT/e1 2>&1 | _filter_scratch
> +large_md5="$($GETFATTR_PROG -n user.x --absolute-names --only-values $SCRATCH_MNT/e1 | md5sum)"
> +test "$large_md5" = "$largefile_md5" || \
> +	echo "largefile $largefile_md5 does not match large attr $large_md5"
> +
> +
> +# Leave e2 to try to trip the repair tools, since xfs_repair used to flag
> +# empty leaf blocks incorrectly too.

So we expect there's not corruption at here, and the empty leaf block can
be used properly?

Thanks,
Zorro

> +
> +# success, all done
> +status=0
> +exit
> 

