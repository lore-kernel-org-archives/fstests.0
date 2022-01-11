Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21619C43219
	for <linux-fstests@archiver.kernel.org>; Tue, 11 Jan 2022 03:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347194AbiAKDgG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 10 Jan 2022 22:36:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347471AbiAKDe6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 10 Jan 2022 22:34:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641872097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nbxMTo82mSwgu9LrK3Z8l7p328XxVSTeLoc0Bezsp4Y=;
        b=NDwNV9Rjgn4o59baFxIZgHkbE0Y2kurYwYN83WrmZ77I2GHViyWXUmZ99OYPqtXOerP5F5
        UD0JttLkHsTF3tL5w0ls581fMzLrEO47d4JvlsGiaOSHiO04uimFKQiCWscGLJlC91KRCu
        YF121W2tFJ+xEEdEmrnucEFq3oJNImM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-uLzQyp-aNkSkEmRABfBtiQ-1; Mon, 10 Jan 2022 22:34:56 -0500
X-MC-Unique: uLzQyp-aNkSkEmRABfBtiQ-1
Received: by mail-pl1-f199.google.com with SMTP id p15-20020a170903248f00b0014a16f4fdcaso3013250plw.6
        for <fstests@vger.kernel.org>; Mon, 10 Jan 2022 19:34:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=nbxMTo82mSwgu9LrK3Z8l7p328XxVSTeLoc0Bezsp4Y=;
        b=iaCvScmlTDKCzDxxt6oO3U0RfHugtVg6ze801l/2yWB/JPlYOFerE/DgXCi3JycPhl
         VLmPj+geAVsvAZjqPJfhJPWfCBzZLBdGMIi/gXGjqGvbueoW43LqDXnmsN7g54d9swJG
         QVm3/vcJbwSot4RbszePP9yoc1/UIhE7t3klooPgVFBpZ256UFMSxaISXjwMoiuktqEF
         jGONb1SvarPPbRs2WqVD7/v4HZYfqC/0ImTPpAeNHtbDxfk04osIqAsFyxpivBHitkDx
         CaXCV/XGIi/DDi24UgACO0ejnCkD+xcqazW7JHwreEYbeP6KF2+CtaLzmwGhZvsSre23
         LYJw==
X-Gm-Message-State: AOAM532yLrjoUQ+W5oKBDzCw5I4+LrQ8yYZr2PaY4TWXe9+1Y7wEQvUd
        faPElAPc5rtoyAL8OCs78sLTYqMMD1gm+dwFi6CczO6zff5vjMN8ICo3O2h4WxAbKdgF8SPVBqu
        cCx8jVMGYbnVO4sv8iA==
X-Received: by 2002:a63:e64a:: with SMTP id p10mr2392779pgj.331.1641872094982;
        Mon, 10 Jan 2022 19:34:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrKLOMmv6XcPUK2OHJgESZOn9cw3iVB1zU4IMDqubJP+anN1Himl6CZd9a0SjEA/WXq/XwTg==
X-Received: by 2002:a63:e64a:: with SMTP id p10mr2392768pgj.331.1641872094532;
        Mon, 10 Jan 2022 19:34:54 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p50sm5164025pfw.51.2022.01.10.19.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 19:34:54 -0800 (PST)
Date:   Tue, 11 Jan 2022 11:34:50 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Chen Long <chenlongcl.chen@huawei.com>
Cc:     fstests@vger.kernel.org, richard@nod.at
Subject: Re: [PATCH] ubifs: add test for race between listxattr and setxatr
Message-ID: <20220111033450.7grsstpebmol4lor@zlang-mailbox>
Mail-Followup-To: Chen Long <chenlongcl.chen@huawei.com>,
        fstests@vger.kernel.org, richard@nod.at
References: <20220108022431.71751-1-chenlongcl.chen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220108022431.71751-1-chenlongcl.chen@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Jan 08, 2022 at 10:24:31AM +0800, Chen Long wrote:
> Add reproducer for a bug on ubifs where listxattr() copies
> the newly created xattr names regardless of the remaining
> buffer size, fails the assertion of used buffer size, and
> may corrupt buffer memory.
> 
> This is a regression test for three kernel commit:
> 1. f4e3634a3b642 (ubifs: Fix races between xattr_{set|get} and
> 	listxattr operations)
> 2. 819f9ab430a44 (ubifs: Remove ui_mutex in ubifs_xattr_get and
> 	change_xattr)
> 
> Signed-off-by: Chen Long <chenlongcl.chen@huawei.com>
> ---
>  tests/ubifs/001      | 54 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/ubifs/001.out  |  2 ++
>  tests/ubifs/Makefile | 24 ++++++++++++++++++++
>  3 files changed, 80 insertions(+)
>  create mode 100755 tests/ubifs/001
>  create mode 100644 tests/ubifs/001.out
>  create mode 100644 tests/ubifs/Makefile
> 
> diff --git a/tests/ubifs/001 b/tests/ubifs/001
> new file mode 100755
> index 00000000..1e9a4de2
> --- /dev/null
> +++ b/tests/ubifs/001
> @@ -0,0 +1,54 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Huawei.  All Rights Reserved.
> +#
> +# FS QA Test 001
> +#
> +# Regression test for kernel commit:
> +# 1. f4e3634a3b642 (ubifs: Fix races between xattr_{set|get} and
> +#	listxattr operations)
> +# 2. 819f9ab430a44 (ubifs: Remove ui_mutex in ubifs_xattr_get and
> +#	change_xattr)
> +#
> +. ./common/preamble
> +_begin_fstest auto quick attr
> +
> +_cleanup()
> +{
> +    cd /
> +    rm -r -f $tmp.*
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/attr
> +
> +# real QA test starts here
> +_supported_fs ubifs

From the whole test case, I don't think it's an ubifs special case. So we can
make it to be a generic case.

> +_require_test
> +_require_attrs
> +
> +target=$TEST_DIR/$seq
> +touch $target
> +
> +# start a background listxattr
> +runfile="$tmp.listxattr"
> +touch $runfile
> +while [ -e $runfile ]; do

We might can explain at here, that if run getfattr without "-n" option,
it uses listxattr system call, or it uses getxattr system call. It's
the code logic of getfattr.c

        if (opt_name)
                err = print_attribute(path, opt_name, &header_printed);
        else
                err = list_attributes(path, &header_printed);

> +    ${GETFATTR_PROG} $target >/dev/null 2>&1

JFYI: There's a wrapper of ${GETFATTR_PROG} _getfattr().
But if you filter all output of getfattr, I think it's fine to use
${GETFATTR_PROG} directly :)

> +done &
> +
> +# add new xattr continuously
> +largename=`for i in $(seq 0 128); do echo -n a; done`
> +for i in $(seq 0 99); do
> +    ${SETFATTR_PROG} -n user.${largename}.$i -v $i $target
> +done
> +
> +rm -f $runfile
> +wait > /dev/null 2>&1
> +rm -f $target
> +
> +echo "Silence is golden"
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ubifs/001.out b/tests/ubifs/001.out
> new file mode 100644
> index 00000000..88678b8e
> --- /dev/null
> +++ b/tests/ubifs/001.out
> @@ -0,0 +1,2 @@
> +QA output created by 001
> +Silence is golden
> diff --git a/tests/ubifs/Makefile b/tests/ubifs/Makefile
> new file mode 100644
> index 00000000..b464b22b
> --- /dev/null
> +++ b/tests/ubifs/Makefile
> @@ -0,0 +1,24 @@
> +#
> +# Copyright (c) 2003-2005 Silicon Graphics, Inc.  All Rights Reserved.
> +#
> +
> +TOPDIR = ../..
> +include $(TOPDIR)/include/builddefs
> +include $(TOPDIR)/include/buildgrouplist
> +
> +GENERIC_DIR = generic
> +TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(GENERIC_DIR)
> +DIRT = group.list
> +
> +default: $(DIRT)
> +
> +include $(BUILDRULES)
> +
> +install:
> +	$(INSTALL) -m 755 -d $(TARGET_DIR)
> +	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
> +	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> +	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
> +
> +# Nothing.
> +install-dev install-lib:

Make this case to be a generic case, will avoid doing this :)

> -- 
> 2.17.1
> 

