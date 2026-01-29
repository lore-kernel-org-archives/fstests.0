Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC56D372B3D
	for <fstests@vger.kernel.org>; Thu, 29 Jan 2026 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674645; cv=none; b=LcSaM/VAx/8jRLqjkxLN47dDTR66gbDu9vb84KoTSc+2T2ROzx9wEWPy+agB2rgmhld6b/2GtSkjntYX22hiNod0H/RypihkjY0Y2DeMxQYuZ87ciq1IDT1PwiHUepE5NufzwnqaBcRMQ8hzXewcyW3XlS+2LwaoxoNeyqrPy9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674645; c=relaxed/simple;
	bh=Gf3LX0f4RMGwGme01hn+UZXA0IxcZHgN6mtTK19BFJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRDM3yphtKtOBAI2pevIy4ayq2rcWcKjEp0+eDI/MvcNE/jbnK0+Fki9a3S076GMQklICv1X+KPzjMpqkeCXZPW67sKDbMPBl9LRut3URMI1ph2iRoylQsQ0rBz2da4XVAnM469/hYsIVBJcxw3Tb78S1i8/+LkKdGWdkbY7uZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpVQ8Cmf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOmf0iYe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpVQ8Cmf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOmf0iYe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769674642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ALGk80mtrZOC4Hw6AaLgc2x8aPEYmXcW9nhB965jj4k=;
	b=dpVQ8CmfLSOCUH6W6Zlh9MGqXMs7kWxu8Qp9iJZvppGTTm3ZzvlILf5stBgA6jNPSzDXvI
	I+IQaQ6Ud/ZZ8Px1kQ7MPWp56sjBWPIogHGog2BTLzfHlwsa+ZZyMtkXrbdfrln0bLrmbU
	0BpiZdGnWvyUUtNFqIfm8RrDSVvKyG4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-j8f_mRE3N4q5cqKgsT8XQQ-1; Thu, 29 Jan 2026 03:17:21 -0500
X-MC-Unique: j8f_mRE3N4q5cqKgsT8XQQ-1
X-Mimecast-MFC-AGG-ID: j8f_mRE3N4q5cqKgsT8XQQ_1769674640
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so476313a12.3
        for <fstests@vger.kernel.org>; Thu, 29 Jan 2026 00:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769674640; x=1770279440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ALGk80mtrZOC4Hw6AaLgc2x8aPEYmXcW9nhB965jj4k=;
        b=DOmf0iYedeGTdQi/9tPmZnONn6CfPTuV/8Tt3f69ztjz2gqrnp8rX5i54qxqFWlFze
         nl/WD+Q42SLrVt0HrOS+tZIZWHH0hFEenh4dPnZXPwyvelpjcjHt3hcxa/VWkzJJnIXZ
         A4u9s6sSXUILQWOCZQV1a8P5pmQleqjMhJjRUy53m1KXxxre+DUzYAyT2omTAgFfq5rO
         XICnOjsSk+dNgrmF45PRFriaQNMjX2pAYnvps3v06hVCQpCff+PTVMbxWYutY2RCua4u
         bU8FC6Kj8XPBKAH+KLrVqzi3z6Lo/wGHjVGRIRgS9p6R4PDbFZrQXSIBHQqRCxRDXjei
         WaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769674640; x=1770279440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALGk80mtrZOC4Hw6AaLgc2x8aPEYmXcW9nhB965jj4k=;
        b=ECsyumdy0e4ZrodnGgkNWySkES2kReYYmVwzx51qJDXxkJCGtp3izgRgkAwcCcAEie
         tJIFEcacHlKygPvOEjf10bCqLain6xbvHoZhZetiq5jZhZdllU1sf++Zmki0ebZrzMhX
         KgFpOcUyNAPKHYuzjV0H0nRRhu68YQR1XDui+4KFotfpNDdkrLtqS5N3jPVzXrLRAvTV
         ukZRMwwL92yZbJ812JmBnVkZWYO+YZBBf+RXL79ezxELc/R/k8HzD+Uiv55ifiDpTGOR
         Cap6gJHuifBKwk8g4eaxaRx7GNfF4WkJgo1NbdxA/36Ef5H/AaLDp7XzbGoTQ8EidBiU
         WuGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV02sPbyiGdFudvMu5h78OKeIjsKmfTj8TuCck8C2viwXfED8NtIN69HjdiIbZKTuDDGXAPQNYh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6fmNC5NRBrIG+QfdrWCrvyYMH9yGrU+ChRripmkRGmhfJncnp
	9cnsWl2lLlX1EsdSHbtv01ONImLcK52sdYGrAvEfvTBneSntJ4splLfpz3+Zn50GwV5UUj56WyO
	Wpoqb2fPFikFnisJSPAfLBL/wmaMGBU9mlZoaeqg2pAn8QpEboQ16X0qa9Zo=
X-Gm-Gg: AZuq6aJEpgInLP7fO645P+KVDRLVMg4rBVyWm9UvWFcBU1gPUMfBJlTtO1qZ/zYfPkL
	4sS1jLWifYrT9QCgFLYbFuH0D/LDnI7Yvl8h5vqmqZfY0QaZ7rsARsATm2Rsdh+3bQPdI53owLn
	zvNinZXP0baBdeJ5HUzU5OzF/1GC2Z7gb1Ej5rjQXqTmg45Eezus59pjbWGuvCFEGa/TiQOZ/gT
	Y75InXcG97WkxKwYUfRz2RWhTSYCjIidkmcsat3MwIYDj25BEB2wXrFf/moYxmNjHM2YPj0s3Xr
	IHFb4vXDgDrXIauc+40SENvqx4KepaehILod0IcgB4irnAO4mzWs9l6TY8jHFllQJNVbb8sE7/D
	4jBZIi0qumwV3bbMI1v+d96BUQHhDn79+nkzmTkt0vC7Xh8koSw==
X-Received: by 2002:a05:6a20:568e:b0:38b:ec0d:51e0 with SMTP id adf61e73a8af0-38ec6548470mr7751186637.68.1769674640426;
        Thu, 29 Jan 2026 00:17:20 -0800 (PST)
X-Received: by 2002:a05:6a20:568e:b0:38b:ec0d:51e0 with SMTP id adf61e73a8af0-38ec6548470mr7751162637.68.1769674639830;
        Thu, 29 Jan 2026 00:17:19 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c64283710e1sm4236094a12.14.2026.01.29.00.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:17:18 -0800 (PST)
Date: Thu, 29 Jan 2026 16:17:14 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2026.01.27
Message-ID: <20260129081714.ca55uinqm3gngmgs@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <e722a754c0ae8ed500fcdc16736a9202@kernel.org>
 <20260127154715.GC5916@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127154715.GC5916@frogsfrogsfrogs>

On Tue, Jan 27, 2026 at 07:47:15AM -0800, Darrick J. Wong wrote:
> On Tue, Jan 27, 2026 at 02:58:36PM +0800, Zorro Lang wrote:
> > Hi all,
> > 
> > The for-next branch of the xfstests repository at:
> > 
> > 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > 
> > has just been updated and tagged as v2026.01.27 release.
> 
> I see that master did indeed jump to the Jan 5 tag, but for-next still
> seems to be at v2026.01.05?

Hi Darrick,

Sorry I didn't notice my for-next pushing returned failure, before writting
and sending this announcement (based on my local commit). I just re-pushed
the for-next branch, feel free to pull again:)

Thanks,
Zorro

> 
> --D
> 
> > Release Notes:
> > 1) There're 3 new test cases in this release, includes btrfs/341, btrfs/342 and
> >    xfs/841.
> > 2) fsstress and fsx don't fail when --duration=0.
> > 
> > More fixes on btrfs, ext4, f2fs, hfs and xfs, please refer to the details below.
> > Thanks for all these contributions.
> > 
> > Thanks,
> > Zorro
> > 
> > The new head of the for-next branch is commit:
> > 
> > 69cd20bd0498 xfs: test reproducible builds
> > 
> > New commits ([N]ew, [U]pdate):
> > 
> > Darrick J. Wong (2):
> > [U]      [754368070ac5] xfs/614: fix test for parent pointers
> > [U]      [31f7192f90a8] misc: allow zero duration for fsstress and fsx
> > 
> > Filipe Manana (2):
> > [N]      [8dad086a4701] btrfs: test power failure after fsync and rename exchanging directories
> > [U]      [e0ded76267f9] fsx: add missing -T option to getopt_long()
> > 
> > Jaegeuk Kim (1):
> > [U]      [096adc20b3df] f2fs/015: Test correct mkfs options for error cases
> > 
> > Luca Di Maio (1):
> > [N]      [69cd20bd0498] xfs: test reproducible builds
> > 
> > Nirjhar Roy (IBM) (1):
> > [U]      [725b08a6d61a] generic/371: Fix the test to be compatible block sizes upto 64k
> > 
> > Ojaswin Mujoo (1):
> > [U]      [a4dbdc5486b4] generic/108: fix test hand upon failure to create LV
> > 
> > Qu Wenruo (2):
> > [U]      [8d2e1bd3d294] fstests: btrfs/131: add explicit v1 space cache requirement
> > [N]      [bc74aaf6859c] fstests: btrfs: add a new test case that is future-proof
> > 
> > Viacheslav Dubeyko (1):
> > [U]      [facf3325d90d] xfstests: hfs/hfsplus don't support metadata journaling
> > 
> > caokewu (1):
> > [U]      [42c2ccaf3700] ext4/307: allocate donor file size dynamically
> > 
> > 
> > Code Diffstat:
> > 
> >  common/btrfs                     |  25 ++++++
> >  common/rc                        |   2 +-
> >  common/xfs                       |   3 +
> >  ltp/fsstress.c                   |   5 +-
> >  ltp/fsx.c                        |   7 +-
> >  tests/btrfs/131                  |  12 ++-
> >  tests/btrfs/341                  |  73 ++++++++++++++++
> >  tests/btrfs/341.out              |  15 ++++
> >  tests/btrfs/342                  | 103 +++++++++++++++++++++++
> >  tests/btrfs/342.out              |  15 ++++
> >  tests/ext4/307                   |   5 +-
> >  tests/f2fs/015                   |  10 ++-
> >  tests/f2fs/015.out               |  92 ++++++++++----------
> >  tests/generic/108                |   7 +-
> >  tests/generic/371                |   2 +-
> >  tests/xfs/614                    |   1 +
> >  tests/xfs/614.cfg                |   4 +
> >  tests/xfs/614.out.lba1024_parent | 177 +++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/614.out.lba2048_parent | 177 +++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/614.out.lba4096_parent | 177 +++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/614.out.lba512_parent  | 177 +++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/841                    | 173 ++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/841.out                |   3 +
> >  23 files changed, 1205 insertions(+), 60 deletions(-)
> > --
> > Zorro Lang
> > zlang@kernel.org
> 
> 

