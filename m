Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2528CA5510
	for <linux-fstests@archiver.kernel.org>; Wed, 13 Sep 2023 08:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbjIMIpk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 13 Sep 2023 04:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbjIMIpk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Sep 2023 04:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93207196
        for <fstests@vger.kernel.org>; Wed, 13 Sep 2023 01:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694594694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7zk+e6lGXVoe2zqXIrledTsI1OczOhqujrNI02hl9tM=;
        b=YvZE43fefshK/K7gfOdB8HS/pK5HewCIoGtGZO+MO9dI1TLD9+E8rgeBaSuW72NTDMfLLI
        8brv/xXSkYZYlIbFYTBhYd+hGsMUxBcMHABpsnmRoEHi7KLU/69ILtotXXolh/9gAbNCbW
        1DGz6Ft6M0kxOfOqCahwn4vUBrIxUfA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-ldcNYJjQPV2ixRZxnhQ6jg-1; Wed, 13 Sep 2023 04:44:53 -0400
X-MC-Unique: ldcNYJjQPV2ixRZxnhQ6jg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a5d86705e4so431947366b.1
        for <fstests@vger.kernel.org>; Wed, 13 Sep 2023 01:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694594692; x=1695199492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zk+e6lGXVoe2zqXIrledTsI1OczOhqujrNI02hl9tM=;
        b=pm1RMivQSBBvjZnm6dyJzFDZcv7mKc5Bx/8u4pZnOljqYOwJcn8UZKXXgHYb+Jg25J
         xjxXoGU5xbIyNROocAjvjJX6+Bg8BhXV6xmsmwFRetfpy5qGwvJTTU7XTcftO0DKmrP6
         n1/9k9GhhOIAitOAPRAN73En+5fRHywZC1hfj7kNoF27U5YLbA/X7COAmw69I8ZXxkDE
         i2IyruOF8MbOGO4l2oHMPFEFttWbjakhwIxqz42wJ6EPfNs2PGEIaJxS9EYSFOXCdE7B
         iCTN9WCb569iaVjkIhnZxRRblx59wptQ/MNS8/qllQ0JJJkljzT8XdzILJ2wDBUZZJ+U
         Htnw==
X-Gm-Message-State: AOJu0Yx/woKfzCVdapgaUJS11E2tyETjJDQesVRCVpl6OZTHoSJCmPje
        PLl71xVkdxp0QtQdg0PRAEcv9Nfzda2aJRVGEwRrrsPORyU86KsjosmZtGjAaw1jcUFg6zjOhBR
        4u+fs2PPZ8eoLjmrs
X-Received: by 2002:a17:907:a066:b0:9a1:bd82:de35 with SMTP id ia6-20020a170907a06600b009a1bd82de35mr1319551ejc.3.1694594692139;
        Wed, 13 Sep 2023 01:44:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRzIVYLCke+Wu7cuYFGMHK50wVmwngt8lYoeHgAmt0A4WBlZg78LlDKJu0vgQzM4ZiKGRuDg==
X-Received: by 2002:a17:907:a066:b0:9a1:bd82:de35 with SMTP id ia6-20020a170907a06600b009a1bd82de35mr1319544ejc.3.1694594691784;
        Wed, 13 Sep 2023 01:44:51 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id y20-20020a170906559400b0098ec690e6d7sm8103038ejp.73.2023.09.13.01.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 01:44:51 -0700 (PDT)
Date:   Wed, 13 Sep 2023 10:44:50 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        fsverity@lists.linux.dev
Subject: Re: [PATCH] common/rc: make _get_max_file_size find file size on
 mount point
Message-ID: <ihs7k3gvnoa5bii5ugng6k3xlr3gerdtrkmkqkxq7yekmnydhf@7v53tjceewuh>
References: <20230911200617.777985-1-aalbersh@redhat.com>
 <20230912124213.q5irip4lbhoasg5i@zlang-mailbox>
 <20230912145625.GD28170@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912145625.GD28170@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2023-09-12 07:56:25, Darrick J. Wong wrote:
> On Tue, Sep 12, 2023 at 08:42:13PM +0800, Zorro Lang wrote:
> > On Mon, Sep 11, 2023 at 10:06:17PM +0200, Andrey Albershteyn wrote:
> > > Currently, _get_max_file_size finds max file size on $TEST_DIR.
> > > The tests/generic/692 uses this function to detect file size and
> > > then tries to create a file on $SCRATCH_MNT.
> > > 
> > > This works fine when test and scratch filesystems have the same
> > > block size. However, it will fail if they differ, for example, TEST
> > > is 4k and SCRATCH is 1k (file will be too big).
> > 
> > I thought we generally use same mkfs options on TEST_DEV and SCRATCH_DEV.
> > If you'd like to test 1k blocksize ext4, shouldn't you make 1k blocksize
> > ext4 on TEST_DEV before testing.
> 
> Agreed, TEST_DEV (AFAIK) is supposed to have the same options as
> SCRATCH_MNT.

Make sense but I didn't know that this is required, would it make
sense to add a check for at least block size? I was running -s
ext4_1k -s ext4_4k without recreating the TEST_DEV and that wasn't
obvious where the problem is as test is using SCRATCH.

> 
> That said, I support adding the flexibility to supply a mount point,
> since that would be generally useful given the number of tests that add
> things to MKFS_OPTIONS...
> 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Found this by running generic/692 on ext4 with -b 1024.
> > > 
> > > Make _get_max_file_size accept mount point on which to detect max
> > > file size.
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > ---
> > >  common/rc         | 8 +++++++-
> > >  tests/generic/299 | 2 +-
> > >  tests/generic/485 | 2 +-
> > >  tests/generic/692 | 2 +-
> > >  4 files changed, 10 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 68d2ad04..d17ec73a 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -4809,7 +4809,13 @@ _require_scratch_feature()
> > >  # be UINT32_MAX * block_size, but other filesystems may allow up to LLONG_MAX.
> > >  _get_max_file_size()
> > >  {
> > > -	local testfile=$TEST_DIR/maxfilesize.$seq
> > > +	if [ -z $1 ] || [ ! -d $1 ]; then
> > > +		echo "Missing mount point argument for _get_max_file_size"
> > > +		exit 1
> > > +	fi
> > > +
> > > +	local mnt=$1
> > > +	local testfile=$mnt/maxfilesize.$seq
> > >  	local l=0
> > >  	local r=9223372036854775807 # LLONG_MAX
> > >  
> > > diff --git a/tests/generic/299 b/tests/generic/299
> > > index d8ecff53..0cd12202 100755
> > > --- a/tests/generic/299
> > > +++ b/tests/generic/299
> > > @@ -30,7 +30,7 @@ NUM_JOBS=$((4*LOAD_FACTOR))
> > >  BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
> > >  FILE_SIZE=$((BLK_DEV_SIZE * 512))
> > >  
> > > -max_file_size=$(_get_max_file_size)
> > > +max_file_size=$(_get_max_file_size $TEST_DIR)
> > >  if [ $max_file_size -lt $FILE_SIZE ]; then
> > >  	FILE_SIZE=$max_file_size
> > >  fi
> > > diff --git a/tests/generic/485 b/tests/generic/485
> > > index 3f7749ff..8bab450b 100755
> > > --- a/tests/generic/485
> > > +++ b/tests/generic/485
> > > @@ -30,7 +30,7 @@ _require_xfs_io_command "finsert"
> > >  _require_xfs_io_command "truncate"
> > >  
> > >  block_size=$(_get_file_block_size $TEST_DIR)
> > > -max_file_size=$(_get_max_file_size)
> > > +max_file_size=$(_get_max_file_size $TEST_DIR)
> > >  max_blocks=$((max_file_size / block_size))
> > >  testfile=$TEST_DIR/testfile.$seq
> > >  
> > > diff --git a/tests/generic/692 b/tests/generic/692
> > > index 95f6ec04..3fb8ac01 100755
> > > --- a/tests/generic/692
> > > +++ b/tests/generic/692
> > > @@ -40,7 +40,7 @@ _scratch_mount
> > >  
> > >  fsv_file=$SCRATCH_MNT/file.fsv
> > >  
> > > -max_sz=$(_get_max_file_size)
> > > +max_sz=$(_get_max_file_size $SCRATCH_MNT)
> 
> ...LGTM, so
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 

Thanks!

> --D
> 
> > >  _fsv_scratch_begin_subtest "way too big: fail on first merkle block"
> > >  truncate -s $max_sz $fsv_file
> > >  _fsv_enable $fsv_file |& _filter_scratch
> > > -- 
> > > 2.40.1
> > > 
> > 
> 

-- 
- Andrey

