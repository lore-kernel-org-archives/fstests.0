Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3F7C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 14 Apr 2022 19:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343522AbiDNTQO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 14 Apr 2022 15:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiDNTQM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 14 Apr 2022 15:16:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69A1AE9C8B
        for <fstests@vger.kernel.org>; Thu, 14 Apr 2022 12:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649963626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y35EtrrG8nDGwmRA46QlP7Y00qu+i5Sp8AVwtRdDgmg=;
        b=HEMzRwEhjFvDprGRvTPfzko25PKG6x9LASGyuxp4oeEOVG+sf5/im/Poi4EnscFRu/LgHm
        Y9ymIgaBRaF658LeJS9hjrFNB+2xQPCqFVnYBz4AveaSPxBA6QHwkqvMpFLQ+kHFaOFWsr
        PkXgR9XdLFhkAN09jtcphGEz1h1n81A=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-Rd8_NJ7qMyuZ_UcEJyopTw-1; Thu, 14 Apr 2022 15:13:45 -0400
X-MC-Unique: Rd8_NJ7qMyuZ_UcEJyopTw-1
Received: by mail-qt1-f198.google.com with SMTP id o2-20020ac86982000000b002f1d71c97b8so2371341qtq.2
        for <fstests@vger.kernel.org>; Thu, 14 Apr 2022 12:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=y35EtrrG8nDGwmRA46QlP7Y00qu+i5Sp8AVwtRdDgmg=;
        b=NywQTj9yF0gUFtRKrd/A+u3Kk18e5FDYvOo9S3TchiqrXgBrmpEf+087U6ef7jcjss
         BnIBiywWoz21xwBBZQa46W3qpyjMZhsbOLffGyJHQTmBdvPopH1axjPPudjmMSip3f5A
         DaMPpq/cXf+7WdS6DELY6taUOOWAlXl+4jI6YfBWlWh0kluVSJbxyOgO4qdx9AhmOGWV
         AlFNta9wo8TVp3rxqO6C67EoqwNsv1cT1A2U18ftqGn87uygl//6lYGmrgEpbVuY4ObB
         /iEGCXHnj2c7lktpUY4/qvS/JkM/kyIeRc8mzjVSFW1EtC7niI15RjRjSl67upaNSPGO
         zgvQ==
X-Gm-Message-State: AOAM533afto2hv44PTz2M4bNxl0YB4wOrwewP5OS5t1OBouhruu1DDdA
        j4GbN0nB8zvoBQxTspzmOjWGouSmei9MJe2VwQvJ0ine+M5ElTGGxJ0uxYgvqwU5EU6ajBGQwCu
        sWXWRyW2DmDhR6//yCQ==
X-Received: by 2002:a37:5505:0:b0:60d:9998:6dfd with SMTP id j5-20020a375505000000b0060d99986dfdmr3168052qkb.607.1649963624826;
        Thu, 14 Apr 2022 12:13:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3DuKMObpBwrklIcw1FPO9ytNPAmepMzwJtfMxSx2F7dWjMbYPAuZrPWYNbIWZDiRbtWG47w==
X-Received: by 2002:a37:5505:0:b0:60d:9998:6dfd with SMTP id j5-20020a375505000000b0060d99986dfdmr3168036qkb.607.1649963624556;
        Thu, 14 Apr 2022 12:13:44 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i18-20020ac85c12000000b002eea9d556c9sm1593457qti.20.2022.04.14.12.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 12:13:44 -0700 (PDT)
Date:   Fri, 15 Apr 2022 03:13:38 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 4/4] generic: test that renaming into a directory fails
 with EDQUOT
Message-ID: <20220414191338.tc7vrhxfqlkml4fu@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        linux-xfs@vger.kernel.org, fstests@vger.kernel.org
References: <164971767143.169983.12905331894414458027.stgit@magnolia>
 <164971769398.169983.1284630275364529313.stgit@magnolia>
 <20220412172930.fv2uofjqxgeo5tft@zlang-mailbox>
 <20220412175827.GI16799@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412175827.GI16799@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 12, 2022 at 10:58:27AM -0700, Darrick J. Wong wrote:
> On Wed, Apr 13, 2022 at 01:29:30AM +0800, Zorro Lang wrote:
> > On Mon, Apr 11, 2022 at 03:54:54PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Add a regression test to make sure that unprivileged userspace renaming
> > > within a directory fails with EDQUOT when the directory quota limits have
> > > been exceeded.
> > > 
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >  tests/generic/833     |   71 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/833.out |    3 ++
> > >  2 files changed, 74 insertions(+)
> > >  create mode 100755 tests/generic/833
> > >  create mode 100644 tests/generic/833.out
> > > 
> > > 
> > > diff --git a/tests/generic/833 b/tests/generic/833
> > > new file mode 100755
> > > index 00000000..a1b3cbc0
> > > --- /dev/null
> > > +++ b/tests/generic/833
> > > @@ -0,0 +1,71 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2022 Oracle.  All Rights Reserved.
> > > +#
> > > +# FS QA Test No. 833
> > > +#
> > > +# Ensure that unprivileged userspace hits EDQUOT while moving files into a
> > > +# directory when the directory's quota limits have been exceeded.
> > > +#
> > > +# Regression test for commit:
> > > +#
> > > +# 41667260bc84 ("xfs: reserve quota for target dir expansion when renaming files")
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick quota
> > > +
> > > +# Import common functions.
> > > +. ./common/filter
> > > +. ./common/quota
> > > +
> > > +# real QA test starts here
> > > +
> > > +# Modify as appropriate.
> > > +_supported_fs generic
> > > +_require_quota
> > > +_require_user
> > > +_require_scratch
> > > +
> > > +_scratch_mkfs > "$seqres.full" 2>&1
> > > +_qmount_option usrquota
> > > +_qmount
> > > +
> > > +blocksize=$(_get_block_size $SCRATCH_MNT)
> > > +scratchdir=$SCRATCH_MNT/dir
> > > +scratchfile=$SCRATCH_MNT/file
> > > +stagedir=$SCRATCH_MNT/staging
> > > +mkdir $scratchdir $stagedir
> > > +touch $scratchfile
> > > +
> > > +# Create a 2-block directory for our 1-block quota limit
> > > +total_size=$((blocksize * 2))
> > > +dirents=$((total_size / 255))
> > > +
> > > +for ((i = 0; i < dirents; i++)); do
> > > +	name=$(printf "x%0254d" $i)
> > > +	ln $scratchfile $scratchdir/$name
> > > +done
> > > +
> > > +# Set a low quota hardlimit for an unprivileged uid and chown the files to it
> > > +echo "set up quota" >> $seqres.full
> > > +setquota -u $qa_user 0 "$((blocksize / 1024))" 0 0 $SCRATCH_MNT
> > > +chown $qa_user $scratchdir $scratchfile
> > > +repquota -upn $SCRATCH_MNT >> $seqres.full
> > > +
> > > +# Fail at renaming into the directory as qa_user to ensure quota enforcement
> > > +# works
> > > +chmod a+rwx $stagedir
> > > +echo "fail quota" >> $seqres.full
> > > +for ((i = 0; i < dirents; i++)); do
> > > +	name=$(printf "y%0254d" $i)
> > > +	ln $scratchfile $stagedir/$name
> > > +	su - "$qa_user" -c "mv $stagedir/$name $scratchdir/$name" 2>&1 | \
> > 
> > Same as [PATCH 3/4], do we need "--login"?
> > Oh, I just found there's only one case generic/128 use this option too. Anyway I
> > have no reason to object it, just speak out for review:)
> 
> <nod> I have the same response as the previous patch. ;)

Same as [PATCH 3/4], we'll help to deal with the "-".

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > > +		_filter_scratch | sed -e 's/y[0-9]*/yXXX/g'
> > > +	test "${PIPESTATUS[0]}" -ne 0 && break
> > > +done
> > > +repquota -upn $SCRATCH_MNT >> $seqres.full
> > > +
> > > +# success, all done
> > > +echo Silence is golden
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/833.out b/tests/generic/833.out
> > > new file mode 100644
> > > index 00000000..d100fa07
> > > --- /dev/null
> > > +++ b/tests/generic/833.out
> > > @@ -0,0 +1,3 @@
> > > +QA output created by 833
> > > +mv: cannot move 'SCRATCH_MNT/staging/yXXX' to 'SCRATCH_MNT/dir/yXXX': Disk quota exceeded
> > > +Silence is golden
> > > 
> > 
> 

