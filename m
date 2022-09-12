Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61423ECAAD5
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Sep 2022 15:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiILPJi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 12 Sep 2022 11:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiILPJh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 12 Sep 2022 11:09:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190D8287
        for <fstests@vger.kernel.org>; Mon, 12 Sep 2022 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662995374;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=T1tDCI1uVOj3W6q0V/sjEFz90fkKQidKMTIKCOvPX0U=;
        b=M92nl0DBGgHQu9R0m8ny8p6QQDr5XzsUTEFJ67ad9by7gzpFNWlDdOLtCp5wp5EUjavDwP
        QD3m+tLc6AdAG8Q2DMdvu2mIBkQRR2rJfQYnV8gVey2v9ifoMY07AMlHvseQyZDtm2rwDD
        K6RlIPpD3CSO4qxh3Ezauz7IULU6KPE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-311-wKMsUVjYN1GLb0qJF-OleQ-1; Mon, 12 Sep 2022 11:09:32 -0400
X-MC-Unique: wKMsUVjYN1GLb0qJF-OleQ-1
Received: by mail-ed1-f72.google.com with SMTP id s17-20020a056402521100b004511c8d59e3so5903041edd.11
        for <fstests@vger.kernel.org>; Mon, 12 Sep 2022 08:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=T1tDCI1uVOj3W6q0V/sjEFz90fkKQidKMTIKCOvPX0U=;
        b=L44B2WCROrBUywnaHZC9V8lflab2OZ292Xeyao+WZ6j0IbSuY4h5xhvclzWuzCW5+d
         3sZSBtynlVktPw/UebF5bUKTbaQGlb+9tyfw/eazqytR5B9egLHdkoTuBQybIgXerh5d
         pYCIy1fd56/0bzmVOIunWPQetGneL74qvAoWKOhay/0tBo1lsmdqQbG+Uoi5DGVDNXlp
         G2gLkkmDuWSd9+Hsz2Syka9EAQdaE+LtdN1ahXvS4pUFlb6bRLd0zh1Swt99Rx/kJrjD
         vQlylUpWijC6uxHVyGUgOQPDWbCIQEFcPN6yUl8C6C41oeRgTCecc4YXTXTSlwSRBmel
         VapA==
X-Gm-Message-State: ACgBeo1mc97qB/RbvZeoIz9BsAOdRQ6hQkp9fTLgdoHr/F3n9+FY7Uci
        PGjrNmGeiPXj1tI5w28Ex3RMDKOvJQQVnBVDwzj7AZEak8D8VXifU1VEJ5g93382ez6JnYCxPF9
        mDyOZR4EZW7+oY0RA
X-Received: by 2002:a05:6402:5106:b0:451:787c:9fcc with SMTP id m6-20020a056402510600b00451787c9fccmr7063359edd.164.1662995371667;
        Mon, 12 Sep 2022 08:09:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7lFUMG0xrxJ5ZBimgCaZ8qp2fxGKnFvL5eiQQHToD8ijh//9AIU94k6t+WHUXGyXJLbBvoPw==
X-Received: by 2002:a05:6402:5106:b0:451:787c:9fcc with SMTP id m6-20020a056402510600b00451787c9fccmr7063345edd.164.1662995371412;
        Mon, 12 Sep 2022 08:09:31 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id p5-20020a50cd85000000b0043ba7df7a42sm5934260edi.26.2022.09.12.08.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 08:09:30 -0700 (PDT)
Date:   Mon, 12 Sep 2022 17:09:29 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3] xfs: test xfs_quota's 'dump' and 'report' -L/-R range
 parameters
Message-ID: <20220912150929.drmewflfct7h6zht@aalbersh.remote.csb>
Reply-To: 20220909034950.pxim3itf6qiusidl@zlang-mailbox
References: <20220805172531.520862-1-aalbersh@redhat.com>
 <20220909034950.pxim3itf6qiusidl@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909034950.pxim3itf6qiusidl@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Sep 09, 2022 at 11:49:50AM +0800, Zorro Lang wrote:
> On Fri, Aug 05, 2022 at 07:25:31PM +0200, Andrey Albershteyn wrote:
> > These parameters define ID range of users/groups/projects to show.
> > This test adds more checks for wider coverage (e.g. empty range,
> > full range, open range).
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > ---
> > 
> > This is regression test in relation to the patch [1].
> 
> If this's a regression test case for a specific patchset, will it fail
> on the kernel without this patchset?
> 

This is on xfs_quota from xfsprogs. This won't fail with older or updated
xfs_quota. I implemented it as those arguments weren't covered by any test.

Ops, sorry, I was going to check in which version this patchset was merged, and
looks like it got lost somewhere between releases. The new version should go
into 6.0 release [1].

[1]: https://lore.kernel.org/linux-xfs/20220912142823.30865-1-aalbersh@redhat.com/T/#t

> > 
> > Changes from v1:
> >  - Moved to separate test (initially added to 152)
> > Changes from v2:
> >  - sed expression simplification
> >  - remove _filter_trailing_spaces() from common/filter
> >  - easier to read test cases
> > 
> > [1]: https://lore.kernel.org/all/20220328222503.146496-1-aalbersh@redhat.com/
> > 
> > ---
> >  tests/xfs/550     | 169 +++++++++++++++++++++++++++++++++
> >  tests/xfs/550.out | 232 ++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 401 insertions(+)
> >  create mode 100755 tests/xfs/550
> >  create mode 100644 tests/xfs/550.out
> > 
> > diff --git a/tests/xfs/550 b/tests/xfs/550
> > new file mode 100755
> > index 00000000..1fc1d37c
> > --- /dev/null
> > +++ b/tests/xfs/550
> > @@ -0,0 +1,169 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 Andrey Albershteyn <aalbersh@redhat.com>.
> > +# All Rights Reserved.
> > +#
> > +# FS QA Test 550
> > +#
> > +# Test xfs_quota -L/-U range parameters for report and dump commands. These
> > +# parameters define ID range of users/groups/projects with non-zero quota to
> > +# show.
> > +#
> > +. ./common/preamble
> > +_begin_fstest quick quota
> 
> Can it be in "auto" group?
> 

sure.

> > +
> > +# Override the default cleanup function.
> > +_cleanup()
> > +{
> > +	_scratch_unmount >/dev/null 2>&1
> 
> Why a _scratch_unmount is needed at here? I think this case doesn't need
> a specific _cleanup.
> 

Yup, thanks! Will remove that.

> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +. ./common/quota
> > +
> > +# real QA test starts here
> > +_supported_fs xfs
> > +_require_test
> 
> I didn't see this case need TEST_DIR, so this requirement might be useless
> 

It is. Will remove that

> > +_require_scratch
> > +_require_xfs_quota
> > +_require_user fsgqa
> > +_require_user fsgqa2
> > +_require_group fsgqa
> > +_require_group fsgqa2
> > +
> > +_scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
> > +
> > +uqid=`id -u fsgqa`
> > +gqid=`id -g fsgqa`
> > +
> > +uqid2=`id -u fsgqa2`
> > +gqid2=`id -g fsgqa2`
> > +
> > +[ $uqid -ge $uqid2 ] && _notrun \
> > +	"ID of fsgqa user ($uqid) expected to be lower than fsgqa2 ($uqid2)"
> > +[ $gqid -ge $gqid2 ] && _notrun \
> > +	"ID of fsgqa group ($gqid) expected to be lower than fsgqa2 ($gqid2)"
> > +
> > +pqid=10
> > +pqid2=42
> > +cat >$tmp.projects <<EOF
> > +$pqid:$SCRATCH_MNT
> > +$pqid2:$SCRATCH_MNT
> > +EOF
> > +
> > +cat >$tmp.projid <<EOF
> > +root:0
> > +fsgqa:$pqid
> > +fsgqa2:$pqid2
> > +EOF
> > +
> > +filter_dump()
> > +{
> > +	_filter_scratch | sed -e 's/^[0-9]\+/#ID/' -e 's/\s*$//'
> > +}
> > +
> > +filter_report()
> > +{
> > +	_filter_quota | sed -e '/^root/d' \
> > +				-e '/^#0/d' \
> > +				-e 's/^#[0-9]\+/#ID/' \
> > +				-e 's/\s*$//'
> > +}
> > +
> > +set_quota_limit()
> > +{
> > +	local bs=$1
> > +	local bh=$2
> > +	local is=$3
> > +	local ih=$4
> > +	local user=$5
> > +
> > +	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> > +			-c "limit -$type bsoft=$bs bhard=$bh $user" \
> > +			-c "limit -$type isoft=$is ihard=$ih $user" \
> > +			$SCRATCH_MNT
> > +}
> > +
> > +test_dump()
> > +{
> > +	local description=$1 ; shift
> > +	local opt="$*"
> > +
> > +	echo "Options: $description"
> > +
> > +	rm -f $tmp.backup 2>>/dev/null
> > +	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> > +			-c "dump -$type $opt -f $tmp.backup" \
> > +			$SCRATCH_MNT | _filter_scratch
> > +	cat $tmp.backup | filter_dump
> > +}
> > +
> > +test_report()
> > +{
> > +	local description=$1 ; shift
> > +	local opt="$*"
> > +
> > +	echo "Options: $description"
> > +
> > +	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> > +			-c "report -$type $opt -bi" \
> > +			$SCRATCH_MNT | filter_report
> > +}
> > +
> > +test_xfs_quota()
> > +{
> > +	set_quota_limit 512k 2048k 10 20 $id
> > +	set_quota_limit 1024k 4096k 10 20 $id2
> > +
> > +	echo "dump options test (type=$type)"
> > +	test_dump "no options (full range)"
> > +	test_dump "-L option" -L $id
> > +	test_dump "-U option" -U $id
> > +	test_dump "-L/-U options (one element range)" -L $id -U $id
> > +	test_dump "-L/-U options (multiple elements range)" -L $id -U $id2
> > +	test_dump "-L/-U options (empty range)" -L $id2 -U $id
> > +	test_dump "-L/-U options (full range)" -L 0 -U 0
> > +
> > +	echo "report options test (type=$type)"
> > +	test_report "no options (full range)"
> > +	test_report "-L options" -L $id
> > +	test_report "-U options" -U $id
> > +	test_report "-L/-U options (one element range)" -L $id -U $id
> > +	test_report "-L/-U options (multiple elements range)" -L $id -U $id2
> > +	test_report "-L/-U options (empty range)" -L $id2 -U $id
> > +	test_report "-L/-U options (full range)" -L 0 -U 0
> > +}
> > +
> > +echo "Checking User quota"
> > +_scratch_unmount >/dev/null 2>&1
> > +_qmount_option "uquota"
> > +_try_scratch_mount || _fail "qmount failed"
> 
> Why not use "_qmount" directly? (same below)
> 

Sure, will change to "_qmount", missed that this exists.

> Thanks,
> Zorro
> 

-- 
- Andrey

