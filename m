Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E578E28640C
	for <fstests@vger.kernel.org>; Tue, 21 Oct 2025 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039783; cv=none; b=a7t4sUd6r4qFfQ26ClmtxR1awDaKdor9/bbtzfoi8o8fem+s49Ew9KJaO0Z/ddCdY3Gii65mwSDQgb8Q0CyMOMBnXsqTrJrPrzCSCvtNps3S0M8YAX8EYaY1jEsMzWbZefhqIfrXgGBXx0R2oww28bo9OsZaMDk83NSeH49/d9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039783; c=relaxed/simple;
	bh=P4gCDvH/zMOQGJkEZiaJWtdsJmoEYgSWmOfl8171fOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iC19NBnR1PZSilsZc2+Vba5Xtal/iQuKdGPaixCpCIXt7P+OLx3Jw/wVm9tiIuqMQCX5FiJpOCfwmZ8RE2m6hokwHk59FnMUpHrWFA4V9xoEJV/ZGYA7QBXGjvJzQ3sWKaPS2V8pbFy8bWiPWSdVe+1a9PMZqis/l1pVm3l6U9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eCRWr7xt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCRWr7xt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761039780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CAiylbs5rXtcRmqiMyDqRxwPYODKhX4aswI7sohZIDE=;
	b=eCRWr7xtKA3Osb94AOtzgge4wMyYkFKuxAB25rJp/VELbg3p39zUzFO7FN68ZG3ENqtofs
	JwmmqWJwh7edQCtvGCZoTrQBuU8b1sL2xEmxWz9Pu61ydtQm+nVt7bOwIjsPn3Y+75C4sv
	+AYlh8lFsmGIvgPU8h71/9lv19AbEbY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-8FsAuCfyP5e96qogZ5G-_A-1; Tue, 21 Oct 2025 05:42:59 -0400
X-MC-Unique: 8FsAuCfyP5e96qogZ5G-_A-1
X-Mimecast-MFC-AGG-ID: 8FsAuCfyP5e96qogZ5G-_A_1761039778
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ef9218daf5so6141031f8f.1
        for <fstests@vger.kernel.org>; Tue, 21 Oct 2025 02:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761039778; x=1761644578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAiylbs5rXtcRmqiMyDqRxwPYODKhX4aswI7sohZIDE=;
        b=gZbJQ82q027MSgjinOt1noNQWrlimyFVxq68AkaaMBOmcGmT8iwgvhsTf95z8GMbwc
         BBZ2yqBce1cGrSUCQBxWlDzdR5EzyIF2swN5DXUvx0WrRiZx6uo75WQzJtchcTra+OAF
         wQ8k3IhvFwpNrMevc5VzLIscUcmXOZAFyXhQc7mNT5aRNTDOvfi695KqxnyN9YgC7T3V
         QM9G3DxQTd9gGbnExH6quIwVXY06z/IeroLtx5egeuquRBoE0B4OD0ZLA7lerXycxPUQ
         IaxKxOCWW8TJoGkRKVaTL4R4Nrq9nqFYN0GbgEWyF2/2zOguNprJ7U7tLZV7DtDJl5IS
         fIxA==
X-Forwarded-Encrypted: i=1; AJvYcCXcHARyyP209RYr5Y8v7lB2vjvMwP2XRP1Tyv1nGSQaYBk/jbSJYm62Ht7m/8kA+GF0hSZyjary@vger.kernel.org
X-Gm-Message-State: AOJu0YzyKCneP5U3ASAAZkoZ1BTvst9LhaX7Om2hksjbvpJHVcxoxT8F
	VMzhNMG7w1xqm+AcpRMDv05kQgSOaV/pkF2y/4tQDew6CWK90qnwOWREdEFwuPA3xm3tlJ5yjOu
	euKNHTR57RHyfO0x6pOkzps4QwuIJ0XznqPbvm9UgfnoSVa+OUJRrzTQseKbbu6AfIQ==
X-Gm-Gg: ASbGncvrz3OL+mmiYK1mK+/FvCZMmCKuyqxG+t2tMiIbrfoog3vGSTuP0MFlxY9NDqT
	nymUT51zoC2eQNbxmllgPrKInTLN+m5Cib6Se9iGWMnPFUk24pp5MPW5If2k5YnETNqgM5N/9DA
	XYH39HLOG9gRHIN5gA2ChT0bEtMkM3N5I0UAq8sMbsWJkNP7KmnjM4G6qdVv/6EZ/Hc4yNADo3v
	8V/Soilq8DDhV1Sy029qQJVoDcg8dRo+BB1D6b/wTmJRIEdjQXoHbbFDulfL5e6K+uXCsrfMHkh
	7jv4EqWWHfBHTc1F4I0Kgox8nVkui5lwRQWVfnvZsOKfE65eIfeGnWb7dw9/11ktUnah0j+PnV1
	mt9yTQs8qqfQLNOaQa08=
X-Received: by 2002:a05:6000:2c0e:b0:426:d51c:4be8 with SMTP id ffacd0b85a97d-42704d87e06mr10215304f8f.19.1761039777731;
        Tue, 21 Oct 2025 02:42:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfxdCns6HfXonlhpN1SWHEmy7QcDZ5EriPzm36GKTVH9QB2Akl3rAXfsj/tq17gstph1b2oQ==
X-Received: by 2002:a05:6000:2c0e:b0:426:d51c:4be8 with SMTP id ffacd0b85a97d-42704d87e06mr10215279f8f.19.1761039777208;
        Tue, 21 Oct 2025 02:42:57 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce3aesm19874088f8f.48.2025.10.21.02.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:42:56 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:42:56 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org, zlang@redhat.com, 
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH 2/3] generic/772: require filesystem to support
 file_[g|s]etattr
Message-ID: <zhavh6jregdtrt5e5jhduyijesfyl25gmgjxdur47smv5r3gmo@6pzt54rm5yj3>
References: <20251020135530.1391193-1-aalbersh@kernel.org>
 <20251020135530.1391193-3-aalbersh@kernel.org>
 <20251020164503.GN6178@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020164503.GN6178@frogsfrogsfrogs>

On 2025-10-20 09:45:03, Darrick J. Wong wrote:
> On Mon, Oct 20, 2025 at 03:55:29PM +0200, Andrey Albershteyn wrote:
> > Add _require_* function to check that filesystem support these syscalls
> > on regular and special files.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  common/rc         | 32 ++++++++++++++++++++++++++++++++
> >  tests/generic/772 |  5 ++---
> >  tests/xfs/648     |  7 +++----
> >  3 files changed, 37 insertions(+), 7 deletions(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index dcae5bc33b19..78928c27da97 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -5994,6 +5994,38 @@ _require_inplace_writes()
> >  	fi
> >  }
> >  
> > +# Require filesystem to support file_getattr()/file_setattr() syscalls on
> > +# regular files
> > +_require_file_attr()
> > +{
> > +	local test_file="$SCRATCH_MNT/foo"
> 
> Should the test file be on $TEST_DIR so that you don't have an implicit
> dependency on _require_scratch?
> 
> Otherwise looks fine to me.

Oh right, will send v2

> 
> --D
> 
> > +	touch $test_file
> > +
> > +	$here/src/file_attr --set --set-nodump $SCRATCH_MNT ./foo &>/dev/null
> > +	rc=$?
> > +	rm -f "$test_file"
> > +
> > +	if [ $rc -ne 0 ]; then
> > +		_notrun "file_getattr not supported for regular files on $FSTYP"
> > +	fi
> > +}
> > +
> > +# Require filesystem to support file_getattr()/file_setattr() syscalls on
> > +# special files (chardev, fifo...)
> > +_require_file_attr_special()
> > +{
> > +	local test_file="$SCRATCH_MNT/fifo"
> > +	mkfifo $test_file
> > +
> > +	$here/src/file_attr --set --set-nodump $SCRATCH_MNT ./fifo &>/dev/null
> > +	rc=$?
> > +	rm -f "$test_file"
> > +
> > +	if [ $rc -ne 0 ]; then
> > +		_notrun "file_getattr not supported for special files on $FSTYP"
> > +	fi
> > +}
> > +
> >  ################################################################################
> >  # make sure this script returns success
> >  /bin/true
> > diff --git a/tests/generic/772 b/tests/generic/772
> > index e68a67246544..bdd55b10f310 100755
> > --- a/tests/generic/772
> > +++ b/tests/generic/772
> > @@ -20,6 +20,8 @@ _require_mknod
> >  
> >  _scratch_mkfs >>$seqres.full 2>&1
> >  _scratch_mount
> > +_require_file_attr
> > +_require_file_attr_special
> >  
> >  file_attr () {
> >  	$here/src/file_attr $*
> > @@ -43,9 +45,6 @@ touch $projectdir/bar
> >  ln -s $projectdir/bar $projectdir/broken-symlink
> >  rm -f $projectdir/bar
> >  
> > -file_attr --get $projectdir ./fifo &>/dev/null || \
> > -	_notrun "file_getattr not supported on $FSTYP"
> > -
> >  echo "Error codes"
> >  # wrong AT_ flags
> >  file_attr --get --invalid-at $projectdir ./foo
> > diff --git a/tests/xfs/648 b/tests/xfs/648
> > index e3c2fbe00b66..a268bfdb0e2d 100755
> > --- a/tests/xfs/648
> > +++ b/tests/xfs/648
> > @@ -20,10 +20,12 @@ _require_test_program "af_unix"
> >  _require_test_program "file_attr"
> >  _require_symlinks
> >  _require_mknod
> > -
> >  _scratch_mkfs >>$seqres.full 2>&1
> >  _qmount_option "pquota"
> >  _scratch_mount
> > +_require_file_attr
> > +_require_file_attr_special
> > +
> >  
> >  create_af_unix () {
> >  	$here/src/af_unix $* || echo af_unix failed
> > @@ -47,9 +49,6 @@ touch $projectdir/bar
> >  ln -s $projectdir/bar $projectdir/broken-symlink
> >  rm -f $projectdir/bar
> >  
> > -$here/src/file_attr --get $projectdir ./fifo &>/dev/null || \
> > -	_notrun "file_getattr not supported on $FSTYP"
> > -
> >  $XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> >  	-c "project -sp $projectdir $id" $SCRATCH_DEV | filter_quota
> >  $XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> > -- 
> > 2.50.1
> > 
> > 
> 

-- 
- Andrey

