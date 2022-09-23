Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCA5ECAAD8
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Sep 2022 14:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiIWOqz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiIWOqx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Sep 2022 10:46:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBF0142E37
        for <fstests@vger.kernel.org>; Fri, 23 Sep 2022 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663944410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H40lw/bCWI9drNhEVO4RrgNa2U+qIWPzkkfvxjoxtKs=;
        b=aBzAt9lJUBivBsB5mdeY2muvYdLu9sylbUG6BFb5dFEHM8e2QOd8K9/o5qxYwjeDbHO1SX
        qTBlvCPFA10fR8UlDxyAfViQufxYA0UxJ1ZCeleFpykGU+/VlXlCWyciMK4HuWSNOzdLJF
        S1ILng7yq0Wb67cqyxHjj3PIs1d6Xkc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-79-ihAwJC7qPTSX-SvLlU96mw-1; Fri, 23 Sep 2022 10:46:49 -0400
X-MC-Unique: ihAwJC7qPTSX-SvLlU96mw-1
Received: by mail-pj1-f71.google.com with SMTP id d1-20020a17090a2a4100b00202ec7968c0so127194pjg.6
        for <fstests@vger.kernel.org>; Fri, 23 Sep 2022 07:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=H40lw/bCWI9drNhEVO4RrgNa2U+qIWPzkkfvxjoxtKs=;
        b=DL/iMq/42VX/2HhVnRhXKDCM6ex1fah6a3UryCdw5TUyJHBLCpWPLk44uCl5Rlpow/
         2yS3OumEUrhBBbfgHp0e2WHSAH+WPoQXhbsmmvDA6llSsDFCU1dB1YD9FoojfJz268s3
         IlAKrHE8PaqVw5EyHYHfJvDXhupLLGWkHG6dVLuuW4x8extFTd5KYMm0JuDriLraH/jO
         ehes6t8M6Se0nRqB5L3/uNTIaZUeRySwmDeG3q+yjeuG1L9zU/MOIY3vZ7Cg7Lw99qQ4
         zS/+1ReAtlk32SglwT9x2nrssS6ZzpgfP1GPvCxWwiQLZAwdQGmtCu1HoZEfWuIStZgT
         J2ZQ==
X-Gm-Message-State: ACrzQf1ghthq2r7uWh0tEO3P1I3JsFOVUBRXvCUQoTTWZXdhAOUgmPau
        8uHbpZQJzTDOhmGxYv1YYMPU5flomV110+DJJF5rAlyeRq/I4nGm+S9D2603dvBZX9bDOSro0cl
        DtEHSxauYowkWtW1S+w==
X-Received: by 2002:a05:6a00:180a:b0:540:a7f6:4393 with SMTP id y10-20020a056a00180a00b00540a7f64393mr9659459pfa.65.1663944408587;
        Fri, 23 Sep 2022 07:46:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6R7VzAGc+gWQtmPBNQvbZ1DkJS7EToMkjX7NIGIH81UScIuDsKOnZSUp+uLJ+l8KgiKv+KqQ==
X-Received: by 2002:a05:6a00:180a:b0:540:a7f6:4393 with SMTP id y10-20020a056a00180a00b00540a7f64393mr9659428pfa.65.1663944408231;
        Fri, 23 Sep 2022 07:46:48 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c17-20020aa79531000000b0054ad9c6b70fsm6508964pfp.8.2022.09.23.07.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 07:46:47 -0700 (PDT)
Date:   Fri, 23 Sep 2022 22:46:43 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Filipe Manana <fdmanana@suse.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v3] btrfs: test xattr changes for RO btrfs property
Message-ID: <20220923144643.ifffuy5usi5hjoaz@zlang-mailbox>
References: <f72207b27052afc7dcbdf4fb7cf956fc37105724.1663840534.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f72207b27052afc7dcbdf4fb7cf956fc37105724.1663840534.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 22, 2022 at 10:56:39AM +0100, fdmanana@kernel.org wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.de>
> 
> Test creation, modification and deletion of xattr for a BTRFS filesystem
> which has the read-only property set to true.
> 
> Re-test the same after read-only property is set to false.
> 
> This tests the bug for "security.*" modifications which escape
> xattr_permission(), because security parameters are usually let through
> in xattr_permission, without checking
> inode_permission()->btrfs_permission().
> 
> This resulted in being able to change a security xattr on a RO subvolume
> until it got fixed by kernel commit b51111271b03 ("btrfs: check if root
> is readonly while setting security xattr").
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
> 
> V3: Use the _getfattr() helper.
>     Redirect mkfs output to the .full file and remove the _fail call,
>     which is an antipattern.
> 
>     Change the subject from:
> 
>     "btrfs: test security xattr changes for RO btrfs property"
> 
>     to:
> 
>     "btrfs: test xattr changes for RO btrfs property"
> 
>     Since it does not test only security xattrs.

This version looks good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>


> 
>  tests/btrfs/275     | 88 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/275.out | 39 ++++++++++++++++++++
>  2 files changed, 127 insertions(+)
>  create mode 100755 tests/btrfs/275
>  create mode 100644 tests/btrfs/275.out
> 
> diff --git a/tests/btrfs/275 b/tests/btrfs/275
> new file mode 100755
> index 00000000..b34fbda0
> --- /dev/null
> +++ b/tests/btrfs/275
> @@ -0,0 +1,88 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test No. 275
> +#
> +# Test that no xattr can be changed once btrfs property is set to RO.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick attr
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/attr
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_fixed_by_kernel_commit b51111271b03 \
> +	"btrfs: check if root is readonly while setting security xattr"
> +_require_attrs
> +_require_btrfs_command "property"
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +FILENAME=$SCRATCH_MNT/foo
> +
> +set_xattr()
> +{
> +	local value=$1
> +	$SETFATTR_PROG -n "user.one" -v $value $FILENAME 2>&1 | _filter_scratch
> +	$SETFATTR_PROG -n "security.one" -v $value $FILENAME 2>&1 | _filter_scratch
> +	$SETFATTR_PROG -n "trusted.one" -v $value $FILENAME 2>&1 | _filter_scratch
> +}
> +
> +get_xattr()
> +{
> +	_getfattr --absolute-names -n "user.one" $FILENAME 2>&1 | _filter_scratch
> +	_getfattr --absolute-names -n "security.one" $FILENAME 2>&1 | _filter_scratch
> +	_getfattr --absolute-names -n "trusted.one" $FILENAME 2>&1 | _filter_scratch
> +}
> +
> +del_xattr()
> +{
> +	$SETFATTR_PROG -x "user.one" $FILENAME 2>&1 | _filter_scratch
> +	$SETFATTR_PROG -x "security.one" $FILENAME 2>&1 | _filter_scratch
> +	$SETFATTR_PROG -x "trusted.one" $FILENAME 2>&1 | _filter_scratch
> +}
> +
> +# Create a test file.
> +echo "hello world" > $FILENAME
> +
> +set_xattr 1
> +
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT ro true
> +$BTRFS_UTIL_PROG property get $SCRATCH_MNT ro
> +
> +# Attempt to change values of RO (property) filesystem.
> +set_xattr 2
> +
> +# Check the values of RO (property) filesystem are not changed.
> +get_xattr
> +
> +# Attempt to remove xattr from RO (property) filesystem.
> +del_xattr
> +
> +# Check if xattr still exist.
> +get_xattr
> +
> +# Change filesystem property RO to false
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT ro false
> +$BTRFS_UTIL_PROG property get $SCRATCH_MNT ro
> +
> +# Change the xattrs after RO is false.
> +set_xattr 2
> +
> +# Get the changed values.
> +get_xattr
> +
> +# Remove xattr.
> +del_xattr
> +
> +# check if the xattrs are really deleted.
> +get_xattr
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/275.out b/tests/btrfs/275.out
> new file mode 100644
> index 00000000..fb8f02f8
> --- /dev/null
> +++ b/tests/btrfs/275.out
> @@ -0,0 +1,39 @@
> +QA output created by 275
> +ro=true
> +setfattr: SCRATCH_MNT/foo: Read-only file system
> +setfattr: SCRATCH_MNT/foo: Read-only file system
> +setfattr: SCRATCH_MNT/foo: Read-only file system
> +# file: SCRATCH_MNT/foo
> +user.one="1"
> +
> +# file: SCRATCH_MNT/foo
> +security.one="1"
> +
> +# file: SCRATCH_MNT/foo
> +trusted.one="1"
> +
> +setfattr: SCRATCH_MNT/foo: Read-only file system
> +setfattr: SCRATCH_MNT/foo: Read-only file system
> +setfattr: SCRATCH_MNT/foo: Read-only file system
> +# file: SCRATCH_MNT/foo
> +user.one="1"
> +
> +# file: SCRATCH_MNT/foo
> +security.one="1"
> +
> +# file: SCRATCH_MNT/foo
> +trusted.one="1"
> +
> +ro=false
> +# file: SCRATCH_MNT/foo
> +user.one="2"
> +
> +# file: SCRATCH_MNT/foo
> +security.one="2"
> +
> +# file: SCRATCH_MNT/foo
> +trusted.one="2"
> +
> +SCRATCH_MNT/foo: user.one: No such attribute
> +SCRATCH_MNT/foo: security.one: No such attribute
> +SCRATCH_MNT/foo: trusted.one: No such attribute
> -- 
> 2.35.1
> 

