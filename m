Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C369FECAAA3
	for <linux-fstests@archiver.kernel.org>; Fri, 26 Aug 2022 10:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245100AbiHZKkl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 26 Aug 2022 06:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343910AbiHZKka (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 26 Aug 2022 06:40:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F8E14023
        for <fstests@vger.kernel.org>; Fri, 26 Aug 2022 03:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661510427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cj0B2Dt7Gf/1QhYAlcvCjZyHMXBTqc3eqJm8SjqLzh4=;
        b=eIUHghqsIDk9F1/CkWsXxrA6VTbKC/gxe1gU2P/sK9sxxeWFETkCryGyksB7J3l4czsCJc
        HhaPptQfk43HiNowVoWTuqanpExke8LdiRAHTjUJjwdYks7MJYOXvtVX/SCrncDVeyPe6p
        2gBlOPmtWhqeeQ7XuNN4sGjtih/HHfI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-159-tPTbl2wlMz6TUsFbDMiiFw-1; Fri, 26 Aug 2022 06:40:26 -0400
X-MC-Unique: tPTbl2wlMz6TUsFbDMiiFw-1
Received: by mail-qv1-f69.google.com with SMTP id ny1-20020a056214398100b00498efa6a165so281732qvb.22
        for <fstests@vger.kernel.org>; Fri, 26 Aug 2022 03:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Cj0B2Dt7Gf/1QhYAlcvCjZyHMXBTqc3eqJm8SjqLzh4=;
        b=0e7YDKNKI3vFS/HbpfttDMt88gu7OVDdkBma2m2KgF7t146bw8fFKaJvEJzqZ05NY8
         MnL6ghHPUT5YqRiM9G8XgHkF8tIhnzgD1Ks3A6sFWksCDvb3i+wkB2wHqEvo0Lw00ejd
         Oyka6Z3RckJ7mVScRqCYGvomdoiHnu7bA9ve+5pW5Ri9vqKY4ZAgloy5krfevQ+WgaWU
         PuUFIbfe+ntWaWJGIuQZIfHPIl/6MeXajc4/eK0u32UBrRcm5ptgnk6HJUql5wypJ42u
         sseEs5b5RDwxOdo3DMHoP5LpyCK928yF6KekKPHgesGniNrhSAT6fw8tx0hbSB4vggpd
         s1ew==
X-Gm-Message-State: ACgBeo2CywMJ4qbRSbbzfqlXu+7Xx/4ksPjIdpNOOsb+xejnVLXPVTBj
        5qme6wk7JQnUj5p7kRgmpK/k7UKMWifh9XmIEfr6/zJQ6irOa4HtmMCv+bFzM7zekXpoSInwBca
        +ZJvi1QpQQoY/izxv4w==
X-Received: by 2002:ac8:5908:0:b0:344:5f5b:5497 with SMTP id 8-20020ac85908000000b003445f5b5497mr7121232qty.632.1661510425678;
        Fri, 26 Aug 2022 03:40:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5u9D/WKNpvRqhCSnm9RnmEFAAICilmTVY9zgZiEDnDJk5+w7KJyYphZ3pOMVow1l+WmyreYw==
X-Received: by 2002:ac8:5908:0:b0:344:5f5b:5497 with SMTP id 8-20020ac85908000000b003445f5b5497mr7121217qty.632.1661510425407;
        Fri, 26 Aug 2022 03:40:25 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n14-20020a05620a294e00b006b8e63dfffbsm1537346qkp.58.2022.08.26.03.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 03:40:24 -0700 (PDT)
Date:   Fri, 26 Aug 2022 18:40:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     sandeen@redhat.com
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic: new test to verify selinux label of whiteout
 inode
Message-ID: <20220826104019.unsdxlb2kkerajfg@zlang-mailbox>
References: <20220714145632.998355-1-zlang@kernel.org>
 <20220725061327.266746-1-zlang@kernel.org>
 <YwTnqpnK9rH7Ori4@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwTnqpnK9rH7Ori4@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 23, 2022 at 07:43:54AM -0700, Darrick J. Wong wrote:
> On Mon, Jul 25, 2022 at 02:13:27PM +0800, Zorro Lang wrote:
> > A but on XFS cause renameat2() with flags=RENAME_WHITEOUT doesn't
> > apply an selinux label. That's quite different with other fs (e.g.
> > ext4, tmpfs).
> > 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> > 
> > Thanks the review points from Amir, this v2 did below changes:
> > 1) Add "whiteout" group
> > 2) Add commit ID from xfs-linux xfs-5.20-merge-2 (will change if need)
> > 3) Rebase to latest fstests for-next branch
> > 
> > Thanks,
> > Zorro
> > 
> >  tests/generic/693     | 64 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/693.out |  2 ++
> >  2 files changed, 66 insertions(+)
> >  create mode 100755 tests/generic/693
> >  create mode 100644 tests/generic/693.out
> > 
> > diff --git a/tests/generic/693 b/tests/generic/693
> > new file mode 100755
> > index 00000000..adf191c4
> > --- /dev/null
> > +++ b/tests/generic/693
> > @@ -0,0 +1,64 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 Red Hat, Copyright.  All Rights Reserved.
> > +#
> > +# FS QA Test No. 693
> > +#
> > +# Verify selinux label can be kept after RENAME_WHITEOUT. This is
> > +# a regression test for:
> > +#   70b589a37e1a ("xfs: add selinux labels to whiteout inodes")
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick rename attr whiteout
> > +
> > +# Import common functions.
> > +. ./common/attr
> > +. ./common/renameat2
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_require_scratch
> > +_require_attrs
> > +_require_renameat2 whiteout
> > +
> > +_fixed_by_kernel_commit 70b589a37e1a \
> > +	xfs: add selinux labels to whiteout inodes
> > +
> > +get_selinux_label()
> > +{
> > +	local label
> > +
> > +	label=`_getfattr --absolute-names -n security.selinux $@ | sed -n 's/security.selinux=\"\(.*\)\"/\1/p'`
> > +	if [ ${PIPESTATUS[0]} -ne 0 -o -z "$label" ];then
> > +		_fail "Fail to get selinux label: $label"
> > +	fi
> > +	echo $label
> > +}
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1
> > +# SELINUX_MOUNT_OPTIONS will be set in common/config if selinux is enabled
> > +if [ -z "$SELINUX_MOUNT_OPTIONS" ]; then
> > +	_notrun "Require selinux to be enabled"
> > +fi
> > +# This test need to verify selinux labels in objects, so unset this selinux
> > +# mount option
> > +export SELINUX_MOUNT_OPTIONS=""
> > +_scratch_mount
> > +
> > +touch $SCRATCH_MNT/f1
> > +echo "Before RENAME_WHITEOUT" >> $seqres.full
> > +ls -lZ $SCRATCH_MNT >> $seqres.full 2>&1
> > +# Expect f1 and f2 have same label after RENAME_WHITEOUT
> > +$here/src/renameat2 -w $SCRATCH_MNT/f1 $SCRATCH_MNT/f2
> > +echo "After RENAME_WHITEOUT" >> $seqres.full
> > +ls -lZ $SCRATCH_MNT >> $seqres.full 2>&1
> > +label1=`get_selinux_label $SCRATCH_MNT/f1`
> > +label2=`get_selinux_label $SCRATCH_MNT/f2`
> 
> The operations of this test look ok to me, but the piece I do not know
> is the higher level context of whether or not it's appropriate for
> whiteout inodes to have selinux labels, or if the selinux developers
> even care.  Perhaps they should be cc'd?  (And maybe I should've made
> Eric do that for the kernel patch...sigh...)

Hi Eric,

May you help to review this patch :)

Thanks,
Zorro

> 
> --D
> 
> > +if [ "$label1" != "$label2" ];then
> > +	echo "$label1 != $label2"
> > +fi
> > +
> > +echo "Silence is golden"
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/693.out b/tests/generic/693.out
> > new file mode 100644
> > index 00000000..01884ea5
> > --- /dev/null
> > +++ b/tests/generic/693.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 693
> > +Silence is golden
> > -- 
> > 2.31.1
> > 
> 

