Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9518223E355
	for <fstests@vger.kernel.org>; Sat, 18 Oct 2025 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760774241; cv=none; b=oaO/G3+or1/+3ZYCZ8TJOjsSWqdW+J+GJmL6iYAwFDosWPw7IgN/y1go65WujaHviQX/st2rHLpkVB2camS95kUQBpoVJAdH3DITyKzScY2YckefJli+7CNqc3y4y2iPe7ETqeGDaut3Bt/bxMB/FYyXZT5xoqNTxdvAPSziXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760774241; c=relaxed/simple;
	bh=Z2Uq0P+iZsBkehpUjLTNEIiTicpbWvHyUuBvYMsqPSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndGpL3Uv82yzDNnXqVGwY1EnidyZzsREhB7rUAnl1JXq0EKIj1MGqTmU9AhAiUtSt/F2/f4ga+e715WL0ERUVsrQUiJbk/kD3owWl7ewn63zcCGxKVI0n06edb+uYSmv8Jq8mwq5YXYSUU0AUUPJzHl2E0r+FJhfYUTd77uj3pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q1xqBbAl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1xqBbAl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760774238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x7S+blNX9xelf5f+/pE2M5lnWf5xx/0K07w1RR+FrCg=;
	b=Q1xqBbAljLNWk++xMRWMGnXN/XRyteFYjbIHvluNCBhcIIVe82333anPAGECuaX8bu01We
	WXXO0Y5BPs08xNs7iLbYUMUPeWgr7jepJVRdMXb1twz0ageJcuqYuX7375UYD1G7aMxEVA
	QyUAeLZAGtt0wOoHpr25CDJFc700hD4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-IijMzEqPNpiLrsZuOW45Rw-1; Sat, 18 Oct 2025 03:57:15 -0400
X-MC-Unique: IijMzEqPNpiLrsZuOW45Rw-1
X-Mimecast-MFC-AGG-ID: IijMzEqPNpiLrsZuOW45Rw_1760774234
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7811e063dceso2451253b3a.2
        for <fstests@vger.kernel.org>; Sat, 18 Oct 2025 00:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760774234; x=1761379034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7S+blNX9xelf5f+/pE2M5lnWf5xx/0K07w1RR+FrCg=;
        b=f/6paOywZTKRQhxPct2YI/bNWLGo7Ov3/9XIogZs1HfoJU4Z4Op94T+/m7oH3s9+15
         +sK5CikSE6GemEQadgbTWoOGdZUmx321fMmtevuOxUhC1MqmlWASo3Ad8zFALBLUSOeA
         gijAEPGEWD1veeWJNeGzBvxeChXIMX/AGyD6k/xxC+cldP6vTjQQJG7Vv9uGODpFe2z5
         Sv6uR8t+qiZ9mv3H8xG/zrSq6jdY3SdTHsl0Nb5EP7rTjrn+BGaRGVaL8PSIdd7eMlFl
         nwvTfMeNmnpm47WfjS7RQrjkVHFP/LGMP40oEcTpatyP9NtKswInJ3Y7mXmMR4MJqLmC
         alIQ==
X-Gm-Message-State: AOJu0YyLIEb3EG9PTcd1Ql1rWLjSylPkd/Q5jxJOxdXjIuPGUnIqhaW7
	1p4DiyS9nHF3wrD2o2HVuJJMHt/XBwu7tH9GNkUZteZW0BzkrVhxGbSQanWC43Aay3s3Xr40o+1
	bW3RS/jL2C7nfLlOXr5ZsgNqqzxC9048oxTLV1LY6xFk00idtkvEHn0jzFGj8EYUB09o=
X-Gm-Gg: ASbGncuUdwzTjNSnE2JtWfoNPYVHhMzYsvv9yR2oFimdUVURT15qYmj2RhNyaCUoyma
	n4eHEfSOdTLAjOz+v2QXmlqWKKzO/BqdaA/i92B2Wz8bjVc1V5xq5d2HE1ly3KcOF75vPiV4AtZ
	kk0v71xm7MvCQbSxND3rvN/zY/rd1lBQR0VFmo09RgMWssTG9zd2jwL6ISaFQjvAaXpcJi4WkEU
	4Oqv9we6CJODQu+4kK+FCQ0y2935/qh00A8eXV6Y9TA/IYoWEas5cEtoiltOM1rIeYpYS8WZ82t
	AHrDyk7QYdQyC/X2nkrwSTbDgjTk0OijFbUCTZ/o27MWsYs1jdBqgWAoQqRraaAhTN8nRWB8H2O
	LNBj0eEiuok5nu41hZuVNQKvWV2PZobsLxtSBGxQ=
X-Received: by 2002:a05:6a00:1a90:b0:783:c2c4:9aa5 with SMTP id d2e1a72fcca58-7a220b10802mr9447604b3a.32.1760774233565;
        Sat, 18 Oct 2025 00:57:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7kk3RQ/EXfDR19z64ks2wGlksMjm9yPZc4Lm4p08VIb21uyZ8Zl3sF94kRP58OLHX+4kFfw==
X-Received: by 2002:a05:6a00:1a90:b0:783:c2c4:9aa5 with SMTP id d2e1a72fcca58-7a220b10802mr9447580b3a.32.1760774233014;
        Sat, 18 Oct 2025 00:57:13 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f2598sm1962322b3a.40.2025.10.18.00.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 00:57:12 -0700 (PDT)
Date: Sat, 18 Oct 2025 15:57:08 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/8] generic/772: actually check for file_getattr special
 file support
Message-ID: <20251018075708.t7agddy5ceisek2e@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <176054617853.2391029.10911105763476647916.stgit@frogsfrogsfrogs>
 <176054617988.2391029.18130416327249525205.stgit@frogsfrogsfrogs>
 <20251017174633.lvfvpv2zoauwo7s7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20251017225448.GH6178@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017225448.GH6178@frogsfrogsfrogs>

On Fri, Oct 17, 2025 at 03:54:48PM -0700, Darrick J. Wong wrote:
> On Sat, Oct 18, 2025 at 01:46:33AM +0800, Zorro Lang wrote:
> > On Wed, Oct 15, 2025 at 09:38:01AM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > On XFS in 6.17, this test fails with:
> > > 
> > >  --- /run/fstests/bin/tests/generic/772.out	2025-10-06 08:27:10.834318149 -0700
> > >  +++ /var/tmp/fstests/generic/772.out.bad	2025-10-08 18:00:34.713388178 -0700
> > >  @@ -9,29 +9,34 @@ Can not get fsxattr on ./foo: Invalid ar
> > >   Can not set fsxattr on ./foo: Invalid argument
> > >   Initial attributes state
> > >   ----------------- SCRATCH_MNT/prj
> > >  ------------------ ./fifo
> > >  ------------------ ./chardev
> > >  ------------------ ./blockdev
> > >  ------------------ ./socket
> > >  ------------------ ./foo
> > >  ------------------ ./symlink
> > >  +Can not get fsxattr on ./fifo: Inappropriate ioctl for device
> > >  +Can not get fsxattr on ./chardev: Inappropriate ioctl for device
> > >  +Can not get fsxattr on ./blockdev: Inappropriate ioctl for device
> > >  +Can not get fsxattr on ./socket: Inappropriate ioctl for device
> > > 
> > > This is a result of XFS' file_getattr implementation rejecting special
> > > files prior to 6.18.  Therefore, skip this new test on old kernels.
> > > 
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  tests/generic/772 |    3 +++
> > >  tests/xfs/648     |    3 +++
> > >  2 files changed, 6 insertions(+)
> > > 
> > > 
> > > diff --git a/tests/generic/772 b/tests/generic/772
> > > index cc1a1bb5bf655c..e68a6724654450 100755
> > > --- a/tests/generic/772
> > > +++ b/tests/generic/772
> > > @@ -43,6 +43,9 @@ touch $projectdir/bar
> > >  ln -s $projectdir/bar $projectdir/broken-symlink
> > >  rm -f $projectdir/bar
> > >  
> > > +file_attr --get $projectdir ./fifo &>/dev/null || \
> > > +	_notrun "file_getattr not supported on $FSTYP"
> > 
> > I'm wondering if a _require_file_attr() is better?
> 
> It's checking specifically that the new getattr syscall works on special
> files.  I suppose you could wrap that in a helper, but I think this is a
> lot more direct about what it's looking for.

Please correct me if I'm wrong. The new syscall is created for setting extended
attributes on special files, therefore I suppose if there's file_setattr syscall
and it can work on regular file, then it can work on any other files the fs supports.
If this's correct, _require_file_attr can use file_attr to try to set and get
attr on a regular file in $TEST_DIR, to make sure the whole file_set/getattr
feature is supported. Is that right?

Thanks,
Zorro

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > > +
> > >  echo "Error codes"
> > >  # wrong AT_ flags
> > >  file_attr --get --invalid-at $projectdir ./foo
> > > diff --git a/tests/xfs/648 b/tests/xfs/648
> > > index 215c809887b609..e3c2fbe00b666a 100755
> > > --- a/tests/xfs/648
> > > +++ b/tests/xfs/648
> > > @@ -47,6 +47,9 @@ touch $projectdir/bar
> > >  ln -s $projectdir/bar $projectdir/broken-symlink
> > >  rm -f $projectdir/bar
> > >  
> > > +$here/src/file_attr --get $projectdir ./fifo &>/dev/null || \
> > > +	_notrun "file_getattr not supported on $FSTYP"
> > > +
> > >  $XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> > >  	-c "project -sp $projectdir $id" $SCRATCH_DEV | filter_quota
> > >  $XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> > > 
> > 
> > 
> 

