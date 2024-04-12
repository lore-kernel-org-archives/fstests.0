Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E4213DDAC
	for <fstests@vger.kernel.org>; Fri, 12 Apr 2024 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712950124; cv=none; b=f8WAnpMcGcWGe0K/6mD6/Amtk/QCeuBJBMUm0eRZSHZQQiLfWrPO2s+nRKAafBZvFzAtSJCAFHd6Lj4GGODfxeH9mtHBvrOFiYFBikg0IlVBpFr54kHrgl1BgeWQFnPM306hlPVOzgBaRSaNP9b8+rq+ZyT7DVNxmlEgTAHgg0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712950124; c=relaxed/simple;
	bh=8mygq248FSK64CaUdLEEXSK/pOHES7kA9HN/MAfEr8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H44au3n1BCsvqt46JLXfdVWQ5Ag0URm3WJrqb1DfVfX4Cd2YUCRO3W2CHxIzMdloWOYNnG06t7c+QpjP7pOFIj4047kYnlfNjQlneTKv4vrMsBxg/pNDT+5CaJLoM0nsE8kNTHcVQ/Y8Jq0SH2jWiU85qAqhE9udPStr4RqRKk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bhXzf9J1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhXzf9J1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712950119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U0GRedC+hqvQXIanVbcgDwhtxr5ofaWQCWcXBPx49hY=;
	b=bhXzf9J1vfypHxJt5I7tbrWsDw2x8W7oJf7I/C/QD+Kh+rSW8fi38fG81a7/PMDX07dB+d
	t5MAjMzMMQpdN38/QjxYbGixBUQo7dfduizpPcI9ls4DFI8ADDIZcAI0ctNQ/jJMyFzinx
	Svaeo1r0Sa2FCtGjRLbLDkAk+xo/e7Y=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-Wx30443FMdS3cZ48LNO25g-1; Fri, 12 Apr 2024 15:28:37 -0400
X-MC-Unique: Wx30443FMdS3cZ48LNO25g-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a300d6a299so1154300a91.3
        for <fstests@vger.kernel.org>; Fri, 12 Apr 2024 12:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712950117; x=1713554917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0GRedC+hqvQXIanVbcgDwhtxr5ofaWQCWcXBPx49hY=;
        b=XSC5uXKlNyBIm0kgjw023doh3YnQcZsMR+Q9ZegXmPCWxFembQMTPTBA1QpcQMN7oN
         a0Tyq+nsWuIX6Af5bT3QnaYLfw5kacAC4V/K7iYTgCZzQS5dCl8ZS+/LPPc0oyOtWRbx
         FUE/MeFwWnveD1RnemIzDeimP3WRdwAqg7b2rlpMtFoM85TaMlO0rJI0p58ib3lM+t/Y
         IXwP8wcepWMCbrCm5sUqiCV39WgC1SlSbyvNF0Z8N+8n1+bmYeAzJcUiLobyry0G/lew
         ZsgX8A95Q+4Ybb5AZgryYt26qoa1ilw6Qj2XhyCQ/Bl3eXLPJ27/JVi5LiBHhA/cBArs
         olvw==
X-Forwarded-Encrypted: i=1; AJvYcCUdHSe5BMc4NjNoOEMD/kOvcMVN4+tQy5MFmHBh3dHzcnEqmb1Lm9zEWoU/amsHvnYOP4BlB3ozcfjS3Aqb6U6b+aGiWwoBeg==
X-Gm-Message-State: AOJu0YzV/bHtQR9eXY2gbqB00ikMjV3X1TVC9oJx44jjdbJKwG8eNb4S
	sFhWA6QwjWbd9wg9GGya1ck/05rCKJpD5BNnH2HPGpOwrhdVu/ME9NGFKjjJazz9GL/EeGV0ovX
	NX98VqoDxAs6cfYuQ8UMZQdwyqsKoGkNiSxHguRRWXuR1Icg+ME3AWNM=
X-Received: by 2002:a17:90a:e10d:b0:2a5:99e6:45a with SMTP id c13-20020a17090ae10d00b002a599e6045amr3616603pjz.29.1712950116325;
        Fri, 12 Apr 2024 12:28:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1kzfFflTRQgwbrt9xLu5Lbamj8WHQsVYAfdnTLkSOqFNxbWGwD5Pkg59Iuq71hsVvnCYMIQ==
X-Received: by 2002:a17:90a:e10d:b0:2a5:99e6:45a with SMTP id c13-20020a17090ae10d00b002a599e6045amr3616569pjz.29.1712950115556;
        Fri, 12 Apr 2024 12:28:35 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090a609600b0029be7922b32sm5255380pji.26.2024.04.12.12.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 12:28:35 -0700 (PDT)
Date: Sat, 13 Apr 2024 03:28:31 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: David Disseldorp <ddiss@suse.de>, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] tests: _fail on _scratch_mkfs_sized failure
Message-ID: <20240412192831.untkqteorxsycrfw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240411063234.30110-1-ddiss@suse.de>
 <20240411063234.30110-2-ddiss@suse.de>
 <20240412154856.GB11935@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412154856.GB11935@frogsfrogsfrogs>

On Fri, Apr 12, 2024 at 08:48:56AM -0700, Darrick J. Wong wrote:
> On Thu, Apr 11, 2024 at 04:32:34PM +1000, David Disseldorp wrote:
> > If _scratch_mkfs_sized() fails, e.g. due to an FS not supporting the
> > provided size, tests may subsequently mount and run atop a previously
> > created (e.g. non-size-bound) filesystem.
> > This can lead to difficult to debug failures, or for some -ENOSPC
> > exercising tests, near infinite runtimes. Avoid this by exiting
> > immediately if _scratch_mkfs_sized() fails.
> 
> I wonder, how many tests should keep going if _scratch_mkfs_sized isn't
> successful?  Would it be simpler to make a _try_scratch_mkfs_sized for
> those callers, and make the main _scratch_mkfs_sized simply do
> 
> _scratch_mkfs_sized()
> {
> 	_try_scratch_mkfs_sized $* || _fail "_scratch_mkfs_sized failed"
> }
> 
> ?

I agree with this. Actually I don't know what's kind of historical reasons
make _scratch_mount _fail directly if mount fails, but _scratch_mkfs
doesn't like that?

Thanks,
Zorro

> 
> --D
> 
> > Signed-off-by: David Disseldorp <ddiss@suse.de>
> > ---
> >  tests/btrfs/057   | 3 ++-
> >  tests/btrfs/132   | 3 ++-
> >  tests/btrfs/170   | 2 +-
> >  tests/btrfs/177   | 2 +-
> >  tests/btrfs/204   | 2 +-
> >  tests/btrfs/217   | 3 ++-
> >  tests/btrfs/237   | 1 +
> >  tests/btrfs/250   | 2 +-
> >  tests/btrfs/253   | 3 ++-
> >  tests/ext4/004    | 3 ++-
> >  tests/ext4/036    | 2 +-
> >  tests/ext4/038    | 3 ++-
> >  tests/ext4/039    | 3 ++-
> >  tests/ext4/048    | 3 ++-
> >  tests/ext4/050    | 3 ++-
> >  tests/ext4/271    | 3 ++-
> >  tests/ext4/307    | 3 ++-
> >  tests/f2fs/001    | 3 ++-
> >  tests/generic/027 | 3 ++-
> >  tests/generic/081 | 3 ++-
> >  tests/generic/085 | 2 +-
> >  tests/generic/096 | 3 ++-
> >  tests/generic/102 | 2 +-
> >  tests/generic/204 | 2 +-
> >  tests/generic/224 | 3 ++-
> >  tests/generic/226 | 3 ++-
> >  tests/generic/250 | 2 +-
> >  tests/generic/252 | 2 +-
> >  tests/generic/256 | 3 ++-
> >  tests/generic/269 | 3 ++-
> >  tests/generic/270 | 3 ++-
> >  tests/generic/273 | 3 ++-
> >  tests/generic/274 | 3 ++-
> >  tests/generic/275 | 3 ++-
> >  tests/generic/300 | 2 +-
> >  tests/generic/312 | 2 +-
> >  tests/generic/320 | 2 +-
> >  tests/generic/333 | 3 ++-
> >  tests/generic/334 | 3 ++-
> >  tests/generic/361 | 3 ++-
> >  tests/generic/371 | 3 ++-
> >  tests/generic/387 | 3 ++-
> >  tests/generic/399 | 2 +-
> >  tests/generic/416 | 2 +-
> >  tests/generic/427 | 3 ++-
> >  tests/generic/449 | 3 ++-
> >  tests/generic/459 | 3 ++-
> >  tests/generic/488 | 3 ++-
> >  tests/generic/511 | 3 ++-
> >  tests/generic/515 | 3 ++-
> >  tests/generic/520 | 2 +-
> >  tests/generic/536 | 3 ++-
> >  tests/generic/546 | 3 ++-
> >  tests/generic/558 | 3 ++-
> >  tests/generic/559 | 2 +-
> >  tests/generic/562 | 3 ++-
> >  tests/generic/619 | 2 +-
> >  tests/generic/626 | 3 ++-
> >  tests/generic/679 | 3 ++-
> >  tests/xfs/075     | 2 +-
> >  tests/xfs/107     | 3 ++-
> >  tests/xfs/118     | 3 ++-
> >  tests/xfs/127     | 3 ++-
> >  tests/xfs/227     | 3 ++-
> >  tests/xfs/233     | 3 ++-
> >  tests/xfs/442     | 3 ++-
> >  tests/xfs/529     | 3 ++-
> >  tests/xfs/532     | 3 ++-
> >  tests/xfs/534     | 3 ++-
> >  tests/xfs/535     | 3 ++-
> >  tests/xfs/538     | 3 ++-
> >  71 files changed, 122 insertions(+), 70 deletions(-)
> > 
> > diff --git a/tests/btrfs/057 b/tests/btrfs/057
> > index e932a657..ff002c86 100755
> > --- a/tests/btrfs/057
> > +++ b/tests/btrfs/057
> > @@ -17,7 +17,8 @@ _supported_fs btrfs
> >  _require_scratch
> >  _require_qgroup_rescan
> >  
> > -_scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  
> >  _scratch_mount
> >  
> > diff --git a/tests/btrfs/132 b/tests/btrfs/132
> > index f50420f5..b10b8e2a 100755
> > --- a/tests/btrfs/132
> > +++ b/tests/btrfs/132
> > @@ -35,7 +35,8 @@ _require_scratch
> >  # to further increase the possibility
> >  # Since the false ENOSPC happens due to incorrect metadata reservation,
> >  # larger nodesize and small fs will make it much easier to reproduce
> > -_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  
> >  # Recommended to use MOUNT_OPTIONS="-o compress" to trigger the bug
> >  _scratch_mount
> > diff --git a/tests/btrfs/170 b/tests/btrfs/170
> > index ab105d36..103d097f 100755
> > --- a/tests/btrfs/170
> > +++ b/tests/btrfs/170
> > @@ -25,7 +25,7 @@ _require_xfs_io_command "falloc" "-k"
> >  # later want to not have more space available for allocating data extents but
> >  # still have enough metadata space free for creating the snapshot.
> >  fs_size=$((2 * 1024 * 1024 * 1024)) # 2Gb
> > -_scratch_mkfs_sized $fs_size >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $fs_size >>$seqres.full 2>&1 || _fail "mkfs failed"
> >  
> >  # Mount without space cache so that we can precisely fill all data space and
> >  # unallocated space later (space cache v1 uses data block groups).
> > diff --git a/tests/btrfs/177 b/tests/btrfs/177
> > index 7b004b83..4de18785 100755
> > --- a/tests/btrfs/177
> > +++ b/tests/btrfs/177
> > @@ -47,7 +47,7 @@ _require_scratch_size $((3 * 1024 * 1024)) #kB
> >  
> >  # First, create a 1GB filesystem.
> >  fssize=$((1024 * 1024 * 1024))
> > -_scratch_mkfs_sized $fssize >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $fssize >> $seqres.full 2>&1 || _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  # Create a small file and run balance so we shall deal with the chunk
> > diff --git a/tests/btrfs/204 b/tests/btrfs/204
> > index ec751e42..7c036181 100755
> > --- a/tests/btrfs/204
> > +++ b/tests/btrfs/204
> > @@ -20,7 +20,7 @@ _supported_fs btrfs
> >  _require_scratch
> >  _require_xfs_io_command "fpunch"
> >  
> > -_scratch_mkfs_sized $((256 * 1024 *1024)) >> $seqres.full
> > +_scratch_mkfs_sized $((256 * 1024 *1024)) >> $seqres.full || _fail "mkfs failed"
> >  
> >  # max_inline ensures data is not inlined within metadata extents
> >  _scratch_mount "-o max_inline=0,nodatacow"
> > diff --git a/tests/btrfs/217 b/tests/btrfs/217
> > index 92bbba23..4be154b0 100755
> > --- a/tests/btrfs/217
> > +++ b/tests/btrfs/217
> > @@ -23,7 +23,8 @@ _require_scratch_size $((5 * 1024 * 1024)) #kB
> >  _require_fstrim
> >  
> >  # Create a 5G fs
> > -_scratch_mkfs_sized $((5 * 1024 * 1024 * 1024)) >> $seqres.full
> > +_scratch_mkfs_sized $((5 * 1024 * 1024 * 1024)) >> $seqres.full \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  # Fstrim to populate the device->alloc_status CHUNK_TRIMMED bits
> > diff --git a/tests/btrfs/237 b/tests/btrfs/237
> > index 367019b6..823bf18a 100755
> > --- a/tests/btrfs/237
> > +++ b/tests/btrfs/237
> > @@ -53,6 +53,7 @@ if [[ $devsize -gt $fssize ]]; then
> >  else
> >  	_scratch_mkfs >> $seqres.full 2>&1
> >  fi
> > +[[ $? -ne 0 ]] && _fail "mkfs failed"
> >  _scratch_mount -o commit=1 # 1s commit time to speed up test
> >  
> >  uuid=$($BTRFS_UTIL_PROG filesystem show $SCRATCH_DEV |grep uuid: |\
> > diff --git a/tests/btrfs/250 b/tests/btrfs/250
> > index e7ddc2f1..ab39bfdb 100755
> > --- a/tests/btrfs/250
> > +++ b/tests/btrfs/250
> > @@ -36,7 +36,7 @@ _require_odirect
> >  # space available for allocating data extents but still have enough metadata
> >  # space free for the file writes.
> >  fs_size=$((1024 * 1024 * 1024)) # 1G
> > -_scratch_mkfs_sized $fs_size >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $fs_size >>$seqres.full 2>&1 || _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  # Create our test file with the NOCOW attribute set.
> > diff --git a/tests/btrfs/253 b/tests/btrfs/253
> > index 5fbce070..2273e690 100755
> > --- a/tests/btrfs/253
> > +++ b/tests/btrfs/253
> > @@ -89,7 +89,8 @@ rm -f "${seqres}.full"
> >  
> >  # Make filesystem. 10GB is needed to test different chunk sizes for
> >  # metadata and data and the default size for volumes > 5GB is different.
> > -_scratch_mkfs_sized $((10 * 1024 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((10 * 1024 * 1024 * 1024)) >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount >> $seqres.full 2>&1
> >  
> >  # Check if there is sufficient sysfs support.
> > diff --git a/tests/ext4/004 b/tests/ext4/004
> > index 0c2ad897..d23cc547 100755
> > --- a/tests/ext4/004
> > +++ b/tests/ext4/004
> > @@ -54,7 +54,8 @@ _require_command "$RESTORE_PROG" restore
> >  
> >  echo "Silence is golden"
> >  
> > -_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  rm -rf $restore_dir $TEST_DIR/restoresymtable
> >  
> > diff --git a/tests/ext4/036 b/tests/ext4/036
> > index 60ab0b90..a4bbe528 100755
> > --- a/tests/ext4/036
> > +++ b/tests/ext4/036
> > @@ -21,7 +21,7 @@ _require_scratch
> >  
> >  echo "Silence is golden"
> >  
> > -_scratch_mkfs_sized $((16*1024*1024)) >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $((16*1024*1024)) >>$seqres.full 2>&1 || _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  # create a file and get its inode number, usually it's 12, but to be accurate
> > diff --git a/tests/ext4/038 b/tests/ext4/038
> > index 596de65b..a84d070b 100755
> > --- a/tests/ext4/038
> > +++ b/tests/ext4/038
> > @@ -23,7 +23,8 @@ echo "Silence is golden"
> >  # it is better to test all reserved inode numbers 1-10 here
> >  for i in {1..10}; do
> >  	# create smaller filesystems to save test time
> > -	_scratch_mkfs_sized $((16 * 1024 * 1024)) >>$seqres.full 2>&1
> > +	_scratch_mkfs_sized $((16 * 1024 * 1024)) >>$seqres.full 2>&1 \
> > +		|| _fail "mkfs failed"
> >  	$DEBUGFS_PROG -w -R "ssv last_orphan $i" $SCRATCH_DEV >>$seqres.full 2>&1
> >  	_scratch_mount
> >  	_scratch_unmount
> > diff --git a/tests/ext4/039 b/tests/ext4/039
> > index 4ca4058a..4945bab2 100755
> > --- a/tests/ext4/039
> > +++ b/tests/ext4/039
> > @@ -61,7 +61,8 @@ _supported_fs ext3 ext4
> >  _require_scratch
> >  _exclude_scratch_mount_option dax
> >  
> > -_scratch_mkfs_sized $((64 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((64 * 1024 * 1024)) >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  if ! _workout; then
> > diff --git a/tests/ext4/048 b/tests/ext4/048
> > index c23c0ea3..a499038e 100755
> > --- a/tests/ext4/048
> > +++ b/tests/ext4/048
> > @@ -81,7 +81,8 @@ test_file1="test0001"
> >  test_file2="test0002"
> >  test_file3="test0003"
> >  
> > -_scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  
> >  # create scratch dir for testing
> >  # create some files with no name a substr of another name so we can grep later
> > diff --git a/tests/ext4/050 b/tests/ext4/050
> > index 6f93b86d..95326771 100755
> > --- a/tests/ext4/050
> > +++ b/tests/ext4/050
> > @@ -24,7 +24,8 @@ _require_test_program "checkpoint_journal"
> >  
> >  testdir="${SCRATCH_MNT}/testdir"
> >  
> > -_scratch_mkfs_sized $((64 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((64 * 1024 * 1024)) >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _require_metadata_journaling $SCRATCH_DEV
> >  _scratch_mount >> $seqres.full 2>&1
> >  blocksize=$(_get_block_size $SCRATCH_MNT)
> > diff --git a/tests/ext4/271 b/tests/ext4/271
> > index 8d9bd7dc..feceb7f3 100755
> > --- a/tests/ext4/271
> > +++ b/tests/ext4/271
> > @@ -20,7 +20,8 @@ _require_scratch
> >  _exclude_scratch_mount_option "data" "commit" "journal_checksum" \
> >  			      "journal_async_commit"
> >  
> > -_scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  
> >  # -onoload and EXT4_SYNC_FL on file is important becase result in
> >  # metadata sync writes inside ext4_handle_dirty_metadata()
> > diff --git a/tests/ext4/307 b/tests/ext4/307
> > index 8b1cfc9e..b63e1e91 100755
> > --- a/tests/ext4/307
> > +++ b/tests/ext4/307
> > @@ -41,7 +41,8 @@ _require_scratch
> >  _require_defrag
> >  _require_xfs_io_command "falloc"
> >  
> > -_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  _workout
> > diff --git a/tests/f2fs/001 b/tests/f2fs/001
> > index 2bf39d8c..4c7d7c7a 100755
> > --- a/tests/f2fs/001
> > +++ b/tests/f2fs/001
> > @@ -29,7 +29,8 @@ testfile=$SCRATCH_MNT/testfile
> >  dummyfile=$SCRATCH_MNT/dummyfile
> >  
> >  # build 4GB filesystem
> > -_scratch_mkfs_sized $((4 * 1024 * 1024 * 1024)) > /dev/null 2>&1
> > +_scratch_mkfs_sized $((4 * 1024 * 1024 * 1024)) > /dev/null 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  echo "==== create small file ===="
> > diff --git a/tests/generic/027 b/tests/generic/027
> > index 47f1981d..a8689a15 100755
> > --- a/tests/generic/027
> > +++ b/tests/generic/027
> > @@ -35,7 +35,8 @@ _require_scratch
> >  
> >  echo "Silence is golden"
> >  
> > -_scratch_mkfs_sized $((256 * 1024 * 1024)) >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $((256 * 1024 * 1024)) >>$seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  echo "Reserve 2M space" >>$seqres.full
> > diff --git a/tests/generic/081 b/tests/generic/081
> > index 0996f221..71ef19e0 100755
> > --- a/tests/generic/081
> > +++ b/tests/generic/081
> > @@ -67,7 +67,8 @@ lvsize=$((size * 85 / 100))	 # ~256M
> >  
> >  # make sure there's enough disk space for 256M lv, test for 300M here in case
> >  # lvm uses some space for metadata
> > -_scratch_mkfs_sized $((size * 1024 * 1024)) >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $((size * 1024 * 1024)) >>$seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
> >  # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
> >  # (like 2.02.95 in RHEL6) don't support --yes option
> > diff --git a/tests/generic/085 b/tests/generic/085
> > index 786d8e6f..7e501cf8 100755
> > --- a/tests/generic/085
> > +++ b/tests/generic/085
> > @@ -52,7 +52,7 @@ echo "Silence is golden"
> >  
> >  size=$((256 * 1024 * 1024))
> >  size_in_sector=$((size / 512))
> > -_scratch_mkfs_sized $size >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $size >>$seqres.full 2>&1 || _fail "mkfs failed"
> >  
> >  node=$seq-test
> >  lvdev=/dev/mapper/$node
> > diff --git a/tests/generic/096 b/tests/generic/096
> > index 41b646c0..d76b2f53 100755
> > --- a/tests/generic/096
> > +++ b/tests/generic/096
> > @@ -23,7 +23,8 @@ _require_xfs_io_command "fzero"
> >  echo "Silence is golden"
> >  
> >  # Use smaller scratch fs to shorten the test time
> > -_scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  testfile=$SCRATCH_MNT/$seq.$$
> > diff --git a/tests/generic/102 b/tests/generic/102
> > index 3536ebf7..396cb80c 100755
> > --- a/tests/generic/102
> > +++ b/tests/generic/102
> > @@ -23,7 +23,7 @@ _supported_fs generic
> >  _require_scratch
> >  
> >  dev_size=$((1024 * 1024 * 1024))     # 1GB filesystem
> > -_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1 || _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  for ((i = 0; i < 10; i++)); do
> > diff --git a/tests/generic/204 b/tests/generic/204
> > index a33a090f..31b920f2 100755
> > --- a/tests/generic/204
> > +++ b/tests/generic/204
> > @@ -31,7 +31,7 @@ _require_scratch
> >  [ $FSTYP = "xfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -l size=16m -i maxpct=50"
> >  
> >  SIZE=`expr 115 \* 1024 \* 1024`
> > -_scratch_mkfs_sized $SIZE 2> /dev/null > $tmp.mkfs.raw
> > +_scratch_mkfs_sized $SIZE 2> /dev/null > $tmp.mkfs.raw || _fail "mkfs failed"
> >  cat $tmp.mkfs.raw | _filter_mkfs 2> $tmp.mkfs > /dev/null
> >  _scratch_mount
> >  
> > diff --git a/tests/generic/224 b/tests/generic/224
> > index 26055ea2..6407aed0 100755
> > --- a/tests/generic/224
> > +++ b/tests/generic/224
> > @@ -30,7 +30,8 @@ _supported_fs generic
> >  _require_scratch
> >  
> >  # make a 1GB filesystem
> > -_scratch_mkfs_sized `expr 1024 \* 1024 \* 1024` > $seqres.full 2>&1
> > +_scratch_mkfs_sized `expr 1024 \* 1024 \* 1024` > $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount >> $seqres.full 2>&1
> >  
> >  # set the reserved block pool to almost empty for XFS
> > diff --git a/tests/generic/226 b/tests/generic/226
> > index 34434730..5b0d5088 100755
> > --- a/tests/generic/226
> > +++ b/tests/generic/226
> > @@ -19,7 +19,8 @@ _require_odirect
> >  
> >  _scratch_unmount 2>/dev/null
> >  echo "--> mkfs 256m filesystem"
> > -_scratch_mkfs_sized `expr 256 \* 1024 \* 1024` >> $seqres.full 2>&1
> > +_scratch_mkfs_sized `expr 256 \* 1024 \* 1024` >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  loops=16
> > diff --git a/tests/generic/250 b/tests/generic/250
> > index 97e9522f..b4b98ad2 100755
> > --- a/tests/generic/250
> > +++ b/tests/generic/250
> > @@ -35,7 +35,7 @@ unset SCRATCH_RTDEV
> >  fssize=$((196 * 1048576))
> >  echo "Format and mount"
> >  $XFS_IO_PROG -d -c "pwrite -S 0x69 -b 1048576 0 $fssize" $SCRATCH_DEV >> $seqres.full
> > -_scratch_mkfs_sized $fssize > $seqres.full 2>&1
> > +_scratch_mkfs_sized $fssize > $seqres.full 2>&1 || _fail "mkfs failed"
> >  _dmerror_init
> >  _dmerror_mount >> $seqres.full 2>&1
> >  _dmerror_unmount
> > diff --git a/tests/generic/252 b/tests/generic/252
> > index 8c5adb53..6108183b 100755
> > --- a/tests/generic/252
> > +++ b/tests/generic/252
> > @@ -36,7 +36,7 @@ unset SCRATCH_RTDEV
> >  fssize=$((196 * 1048576))
> >  echo "Format and mount"
> >  $XFS_IO_PROG -d -c "pwrite -S 0x69 -b 1048576 0 $fssize" $SCRATCH_DEV >> $seqres.full
> > -_scratch_mkfs_sized $fssize > $seqres.full 2>&1
> > +_scratch_mkfs_sized $fssize > $seqres.full 2>&1 || _fail "mkfs failed"
> >  _dmerror_init
> >  _dmerror_mount >> $seqres.full 2>&1
> >  _dmerror_unmount
> > diff --git a/tests/generic/256 b/tests/generic/256
> > index ea6cc293..aa72a2a4 100755
> > --- a/tests/generic/256
> > +++ b/tests/generic/256
> > @@ -89,7 +89,8 @@ _test_full_fs_punch()
> >  
> >  # Make a small file system to fill
> >  _scratch_unmount &> /dev/null
> > -_scratch_mkfs_sized $(( 1536 * 1024 * 1024 )) &> /dev/null
> > +_scratch_mkfs_sized $(( 1536 * 1024 * 1024 )) &> /dev/null \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  # Test must be able to write files with non-root permissions
> >  chmod 777 $SCRATCH_MNT
> > diff --git a/tests/generic/269 b/tests/generic/269
> > index b7cdecd9..c10bc908 100755
> > --- a/tests/generic/269
> > +++ b/tests/generic/269
> > @@ -42,7 +42,8 @@ _workout()
> >  _supported_fs generic
> >  _require_scratch
> >  
> > -_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  if ! _workout; then
> > diff --git a/tests/generic/270 b/tests/generic/270
> > index e7329c2f..3c495a5d 100755
> > --- a/tests/generic/270
> > +++ b/tests/generic/270
> > @@ -61,7 +61,8 @@ _require_command "$KILLALL_PROG" killall
> >  _require_command "$SETCAP_PROG" setcap
> >  _require_attrs security
> >  
> > -_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount "-o usrquota,grpquota"
> >  chmod 777 $SCRATCH_MNT
> >  quotacheck -u -g $SCRATCH_MNT 2>/dev/null
> > diff --git a/tests/generic/273 b/tests/generic/273
> > index 54c19996..53e18be7 100755
> > --- a/tests/generic/273
> > +++ b/tests/generic/273
> > @@ -125,7 +125,8 @@ echo "start the workload"
> >  echo "------------------------------"
> >  
> >  _scratch_unmount 2>/dev/null
> > -_scratch_mkfs_sized $((2 * 1024 * 1024 * 1024)) >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $((2 * 1024 * 1024 * 1024)) >>$seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  _do_workload
> > diff --git a/tests/generic/274 b/tests/generic/274
> > index 8c0e420e..ee1f71ea 100755
> > --- a/tests/generic/274
> > +++ b/tests/generic/274
> > @@ -39,7 +39,8 @@ echo "preallocation test"
> >  echo "------------------------------"
> >  
> >  _scratch_unmount 2>/dev/null
> > -_scratch_mkfs_sized $((2 * 1024 * 1024 * 1024)) >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $((2 * 1024 * 1024 * 1024)) >>$seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  # Create a 4k file and Allocate 4M past EOF on that file
> > diff --git a/tests/generic/275 b/tests/generic/275
> > index f3b05409..effaee63 100755
> > --- a/tests/generic/275
> > +++ b/tests/generic/275
> > @@ -34,7 +34,8 @@ echo "write until ENOSPC test"
> >  echo "------------------------------"
> >  
> >  _scratch_unmount 2>/dev/null
> > -_scratch_mkfs_sized $((2 * 1024 * 1024 * 1024)) >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $((2 * 1024 * 1024 * 1024)) >>$seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  # Certain filesystems such as XFS require sufficient free blocks to handle the
> > diff --git a/tests/generic/300 b/tests/generic/300
> > index 5ff141d3..fea951c3 100755
> > --- a/tests/generic/300
> > +++ b/tests/generic/300
> > @@ -110,7 +110,7 @@ EOF
> >  
> >  _require_fio $fio_config
> >  
> > -_scratch_mkfs_sized $FS_SIZE >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $FS_SIZE >> $seqres.full 2>&1 || _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  echo ""
> > diff --git a/tests/generic/312 b/tests/generic/312
> > index 1926deb8..03ddd7c5 100755
> > --- a/tests/generic/312
> > +++ b/tests/generic/312
> > @@ -23,7 +23,7 @@ _require_scratch
> >  # 5G in byte
> >  fssize=$((2**30 * 5))
> >  
> > -_scratch_mkfs_sized $fssize >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $fssize >>$seqres.full 2>&1 || _fail "mkfs failed"
> >  _scratch_mount >>$seqres.full 2>&1
> >  
> >  echo "Silence is golden"
> > diff --git a/tests/generic/320 b/tests/generic/320
> > index ea65537f..15178435 100755
> > --- a/tests/generic/320
> > +++ b/tests/generic/320
> > @@ -79,7 +79,7 @@ do_workload()
> >  
> >  echo "Silence is golden"
> >  
> > -_scratch_mkfs_sized $fs_size >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $fs_size >>$seqres.full 2>&1 || _fail "mkfs failed"
> >  _scratch_mount >>$seqres.full 2>&1
> >  
> >  do_workload
> > diff --git a/tests/generic/333 b/tests/generic/333
> > index bf1967ce..fad4e357 100755
> > --- a/tests/generic/333
> > +++ b/tests/generic/333
> > @@ -30,7 +30,8 @@ _require_cp_reflink
> >  _require_odirect
> >  
> >  echo "Format and mount"
> > -_scratch_mkfs_sized $((400 * 1048576)) > $seqres.full 2>&1
> > +_scratch_mkfs_sized $((400 * 1048576)) > $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount >> $seqres.full 2>&1
> >  
> >  testdir=$SCRATCH_MNT/test-$seq
> > diff --git a/tests/generic/334 b/tests/generic/334
> > index b9c14b87..f78641d6 100755
> > --- a/tests/generic/334
> > +++ b/tests/generic/334
> > @@ -29,7 +29,8 @@ _require_scratch_reflink
> >  _require_cp_reflink
> >  
> >  echo "Format and mount"
> > -_scratch_mkfs_sized $((400 * 1048576)) > $seqres.full 2>&1
> > +_scratch_mkfs_sized $((400 * 1048576)) > $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount >> $seqres.full 2>&1
> >  
> >  testdir=$SCRATCH_MNT/test-$seq
> > diff --git a/tests/generic/361 b/tests/generic/361
> > index d76d2635..2ba49e9c 100755
> > --- a/tests/generic/361
> > +++ b/tests/generic/361
> > @@ -33,7 +33,8 @@ _require_loop
> >  _require_sparse_files
> >  
> >  # create a small filesystem to hold another filesystem image
> > -_scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  # create the sparse fs image and mount point
> > diff --git a/tests/generic/371 b/tests/generic/371
> > index a2fdaf7b..8861dc40 100755
> > --- a/tests/generic/371
> > +++ b/tests/generic/371
> > @@ -20,7 +20,8 @@ _require_scratch
> >  _require_xfs_io_command "falloc"
> >  test "$FSTYP" = "xfs" && _require_xfs_io_command "extsize"
> >  
> > -_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  # Disable speculative post-EOF preallocation on XFS, which can grow fast enough
> > diff --git a/tests/generic/387 b/tests/generic/387
> > index 25ca86bb..0ee01594 100755
> > --- a/tests/generic/387
> > +++ b/tests/generic/387
> > @@ -19,7 +19,8 @@ _supported_fs generic
> >  _require_scratch_reflink
> >  
> >  #btrfs needs 256mb to create default blockgroup fs
> > -_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  testfile=$SCRATCH_MNT/testfile
> > diff --git a/tests/generic/399 b/tests/generic/399
> > index a5aa7107..dc42d5c8 100755
> > --- a/tests/generic/399
> > +++ b/tests/generic/399
> > @@ -42,7 +42,7 @@ fs_size_in_mb=64
> >  fs_size=$((fs_size_in_mb * 1024 * 1024))
> >  dd if=/dev/zero of=$SCRATCH_DEV bs=$((1024 * 1024)) \
> >  	count=$fs_size_in_mb &>> $seqres.full
> > -_scratch_mkfs_sized_encrypted $fs_size &>> $seqres.full
> > +_scratch_mkfs_sized_encrypted $fs_size &>> $seqres.full || _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  keydesc=$(_generate_session_encryption_key)
> > diff --git a/tests/generic/416 b/tests/generic/416
> > index 0f6e3bc9..b0ce71c9 100755
> > --- a/tests/generic/416
> > +++ b/tests/generic/416
> > @@ -28,7 +28,7 @@ page_size=$(_get_page_size)
> >  nr_files=$(($fs_size / $page_size))
> >  
> >  # Use small fs to make the fill more faster
> > -_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1 || _fail "mkfs failed"
> >  
> >  _scratch_mount
> >  
> > diff --git a/tests/generic/427 b/tests/generic/427
> > index 26385d36..01df59b1 100755
> > --- a/tests/generic/427
> > +++ b/tests/generic/427
> > @@ -27,7 +27,8 @@ _require_aiodio aio-dio-eof-race
> >  _require_no_compress
> >  
> >  # limit the filesystem size, to save the time of filling filesystem
> > -_scratch_mkfs_sized $((256 * 1024 * 1024)) >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $((256 * 1024 * 1024)) >>$seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  # try to write more bytes than filesystem size to fill the filesystem,
> > diff --git a/tests/generic/449 b/tests/generic/449
> > index 2b77a6a4..916d1985 100755
> > --- a/tests/generic/449
> > +++ b/tests/generic/449
> > @@ -24,7 +24,8 @@ _require_test
> >  _require_acls
> >  _require_attrs trusted
> >  
> > -_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount || _fail "mount failed"
> >  
> >  # This is a test of xattr behavior when we run out of disk space for xattrs,
> > diff --git a/tests/generic/459 b/tests/generic/459
> > index c3f0b2b0..57cd0c52 100755
> > --- a/tests/generic/459
> > +++ b/tests/generic/459
> > @@ -76,7 +76,8 @@ is_shutdown_or_ro()
> >  }
> >  
> >  # Ensure we have enough disk space
> > -_scratch_mkfs_sized $((350 * 1024 * 1024)) >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $((350 * 1024 * 1024)) >>$seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  
> >  # Create a 200MB dm-thin POOL
> >  $LVM_PROG pvcreate -f $SCRATCH_DEV >>$seqres.full 2>&1
> > diff --git a/tests/generic/488 b/tests/generic/488
> > index 7b9dcc18..26f08040 100755
> > --- a/tests/generic/488
> > +++ b/tests/generic/488
> > @@ -16,7 +16,8 @@ _supported_fs generic
> >  _require_scratch
> >  _require_test_program "multi_open_unlink"
> >  
> > -_scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  test_file="$SCRATCH_MNT/$seq"
> > diff --git a/tests/generic/511 b/tests/generic/511
> > index 61c21e42..d96d46df 100755
> > --- a/tests/generic/511
> > +++ b/tests/generic/511
> > @@ -19,7 +19,8 @@ _require_scratch
> >  _require_xfs_io_command "falloc" "-k"
> >  _require_xfs_io_command "fzero"
> >  
> > -_scratch_mkfs_sized $((1024 * 1024 * 256)) >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $((1024 * 1024 * 256)) >>$seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  $XFS_IO_PROG -fc "pwrite 0 256m" -c fsync $SCRATCH_MNT/file >>$seqres.full 2>&1
> > diff --git a/tests/generic/515 b/tests/generic/515
> > index 1d537dec..0b14f9e3 100755
> > --- a/tests/generic/515
> > +++ b/tests/generic/515
> > @@ -24,7 +24,8 @@ _require_xfs_io_command "falloc"
> >  # Fill disk with a well known pattern so that stale data exposure becomes much
> >  # more obvious.
> >  $XFS_IO_PROG -c "pwrite -S 0x58 -b 1m 0 300m" $SCRATCH_DEV >> $seqres.full
> > -_scratch_mkfs_sized $((300 * 1048576)) >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $((300 * 1048576)) >>$seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  DONOR1=$SCRATCH_MNT/a
> > diff --git a/tests/generic/520 b/tests/generic/520
> > index ad6764c7..9bf2a6eb 100755
> > --- a/tests/generic/520
> > +++ b/tests/generic/520
> > @@ -33,7 +33,7 @@ _require_scratch_nocheck
> >  _require_dm_target flakey
> >  
> >  # initialize scratch device
> > -_scratch_mkfs_sized $fssize >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $fssize >> $seqres.full 2>&1 || _fail "mkfs failed"
> >  _require_metadata_journaling $SCRATCH_DEV
> >  _init_flakey
> >  
> > diff --git a/tests/generic/536 b/tests/generic/536
> > index 986ea1ee..3ff56914 100755
> > --- a/tests/generic/536
> > +++ b/tests/generic/536
> > @@ -21,7 +21,8 @@ _require_scratch
> >  _require_scratch_shutdown
> >  
> >  # create a small fs and initialize free blocks with a unique pattern
> > -_scratch_mkfs_sized $((1024 * 1024 * 100)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((1024 * 1024 * 100)) >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  $XFS_IO_PROG -f -c "pwrite -S 0xab 0 100m" -c fsync $SCRATCH_MNT/spc \
> >  	>> $seqres.full 2>&1
> > diff --git a/tests/generic/546 b/tests/generic/546
> > index 2eb99543..75de5478 100755
> > --- a/tests/generic/546
> > +++ b/tests/generic/546
> > @@ -35,7 +35,8 @@ _require_xfs_io_command "falloc"
> >  _require_scratch_reflink
> >  _require_dm_target flakey
> >  
> > -_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _require_metadata_journaling $SCRATCH_DEV
> >  _init_flakey
> >  _mount_flakey
> > diff --git a/tests/generic/558 b/tests/generic/558
> > index 510b06f2..c6b9e2e0 100755
> > --- a/tests/generic/558
> > +++ b/tests/generic/558
> > @@ -34,7 +34,8 @@ _require_scratch
> >  
> >  echo "Silence is golden"
> >  
> > -_scratch_mkfs_sized $((1024 * 1024 * 1024)) >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $((1024 * 1024 * 1024)) >>$seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  i=0
> > diff --git a/tests/generic/559 b/tests/generic/559
> > index 98ab4474..26f07443 100755
> > --- a/tests/generic/559
> > +++ b/tests/generic/559
> > @@ -18,7 +18,7 @@ _supported_fs generic
> >  _require_scratch_duperemove
> >  
> >  fssize=$((2 * 1024 * 1024 * 1024))
> > -_scratch_mkfs_sized $fssize > $seqres.full 2>&1
> > +_scratch_mkfs_sized $fssize > $seqres.full 2>&1 || _fail "mkfs failed"
> >  _scratch_mount >> $seqres.full 2>&1
> >  
> >  # fill the fs with a big file has same contents
> > diff --git a/tests/generic/562 b/tests/generic/562
> > index 7d98e569..d5a5993b 100755
> > --- a/tests/generic/562
> > +++ b/tests/generic/562
> > @@ -21,7 +21,8 @@ _require_scratch_reflink
> >  _require_test_program "punch-alternating"
> >  _require_xfs_io_command "fpunch"
> >  
> > -_scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  file_size=$(( 200 * 1024 * 1024 )) # 200Mb
> > diff --git a/tests/generic/619 b/tests/generic/619
> > index c4bdfbce..b844d2f8 100755
> > --- a/tests/generic/619
> > +++ b/tests/generic/619
> > @@ -132,7 +132,7 @@ run_testcase()
> >  
> >  	for i in $(eval echo "{1..$test_iteration_cnt}"); do
> >  		# Setup the device
> > -		_scratch_mkfs_sized $FS_SIZE >> $seqres.full 2>&1
> > +		_scratch_mkfs_sized $FS_SIZE >> $seqres.full 2>&1 || _fail "mkfs failed"
> >  		_scratch_mount
> >  
> >  		debug "===== Test: $test_name iteration: $i starts ====="
> > diff --git a/tests/generic/626 b/tests/generic/626
> > index 7e577798..afb9322a 100755
> > --- a/tests/generic/626
> > +++ b/tests/generic/626
> > @@ -22,7 +22,8 @@ _supported_fs generic
> >  _require_scratch
> >  _require_renameat2 whiteout
> >  
> > -_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  # Create lots of files, to help to trigger the bug easily
> > diff --git a/tests/generic/679 b/tests/generic/679
> > index ddf975a2..f6e95117 100755
> > --- a/tests/generic/679
> > +++ b/tests/generic/679
> > @@ -29,7 +29,8 @@ _supported_fs ^xfs
> >  rm -f $seqres.full
> >  
> >  # Create a 1G filesystem.
> > -_scratch_mkfs_sized $((1024 * 1024 * 1024)) >>$seqres.full 2>&1
> > +_scratch_mkfs_sized $((1024 * 1024 * 1024)) >>$seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  # Create a file with a size of 600M and two holes, each with a size of 1M and
> > diff --git a/tests/xfs/075 b/tests/xfs/075
> > index ec056fb3..82307e68 100755
> > --- a/tests/xfs/075
> > +++ b/tests/xfs/075
> > @@ -22,7 +22,7 @@ _require_scratch
> >  _qmount_option "defaults"
> >  
> >  echo "Silence is golden"
> > -_scratch_mkfs_sized $((512 * 1024 * 1024)) >$seqres.full
> > +_scratch_mkfs_sized $((512 * 1024 * 1024)) >$seqres.full || _fail "mkfs failed"
> >  
> >  # first ro mount with norecovery
> >  _try_scratch_mount "-o ro,norecovery" >>$seqres.full 2>&1 \
> > diff --git a/tests/xfs/107 b/tests/xfs/107
> > index 1ea9c492..c374d15d 100755
> > --- a/tests/xfs/107
> > +++ b/tests/xfs/107
> > @@ -32,7 +32,8 @@ size_mb=256
> >  # reproduce within the first 500KB's worth of ALLOCSP calls, so running up
> >  # to 16MB should suffice.
> >  $XFS_IO_PROG -d -c "pwrite -S 0x58 -b 8m 0 ${size_mb}m" $SCRATCH_DEV > $seqres.full
> > -MKFS_OPTIONS="-K $MKFS_OPTIONS" _scratch_mkfs_sized $((size_mb * 1048576)) >> $seqres.full
> > +MKFS_OPTIONS="-K $MKFS_OPTIONS" _scratch_mkfs_sized $((size_mb * 1048576)) \
> > +	>> $seqres.full || _fail "mkfs failed"
> >  
> >  _scratch_mount
> >  
> > diff --git a/tests/xfs/118 b/tests/xfs/118
> > index 6bb81a3a..f6d17706 100755
> > --- a/tests/xfs/118
> > +++ b/tests/xfs/118
> > @@ -28,7 +28,8 @@ _require_command "$XFS_FSR_PROG" "xfs_fsr"
> >  _require_xfs_io_command "falloc"
> >  
> >  # 50M
> > -_scratch_mkfs_sized $((50 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((50 * 1024 * 1024)) >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  
> >  echo "Silence is golden"
> > diff --git a/tests/xfs/127 b/tests/xfs/127
> > index f39b0582..c4237860 100755
> > --- a/tests/xfs/127
> > +++ b/tests/xfs/127
> > @@ -20,7 +20,8 @@ _require_no_large_scratch_dev
> >  _require_cp_reflink
> >  
> >  echo "Format and mount"
> > -_scratch_mkfs_sized $((512 * 1024 * 1024)) > $seqres.full 2>&1
> > +_scratch_mkfs_sized $((512 * 1024 * 1024)) > $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount >> $seqres.full 2>&1
> >  
> >  testdir=$SCRATCH_MNT/test-$seq
> > diff --git a/tests/xfs/227 b/tests/xfs/227
> > index cd927dc4..0556412c 100755
> > --- a/tests/xfs/227
> > +++ b/tests/xfs/227
> > @@ -122,7 +122,8 @@ create_target_attr_last()
> >  }
> >  
> >  # use a small filesystem so we can control freespace easily
> > -_scratch_mkfs_sized $((50 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs_sized $((50 * 1024 * 1024)) >> $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount
> >  fragment_freespace
> >  
> > diff --git a/tests/xfs/233 b/tests/xfs/233
> > index 2b2b8666..dedd1ef8 100755
> > --- a/tests/xfs/233
> > +++ b/tests/xfs/233
> > @@ -18,7 +18,8 @@ _require_xfs_scratch_rmapbt
> >  _require_no_large_scratch_dev
> >  
> >  echo "Format and mount"
> > -_scratch_mkfs_sized $((2 * 4096 * 4096)) > $seqres.full 2>&1
> > +_scratch_mkfs_sized $((2 * 4096 * 4096)) > $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount >> $seqres.full 2>&1
> >  
> >  testdir=$SCRATCH_MNT/test-$seq
> > diff --git a/tests/xfs/442 b/tests/xfs/442
> > index b04b1c83..d55ccc17 100755
> > --- a/tests/xfs/442
> > +++ b/tests/xfs/442
> > @@ -68,7 +68,8 @@ _qmount_option "usrquota,grpquota,prjquota"
> >  # operations as delalloc for quota accounting") and ("xfs: call
> >  # xfs_qm_dqattach before performing reflink operations") though each of those
> >  # tests now have separate faster-running regression tests.
> > -_scratch_mkfs_sized $((1600 * 1048576)) > $seqres.full 2>&1
> > +_scratch_mkfs_sized $((1600 * 1048576)) > $seqres.full 2>&1 \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount >> $seqres.full 2>&1
> >  
> >  nr_cpus=$((LOAD_FACTOR * 4))
> > diff --git a/tests/xfs/529 b/tests/xfs/529
> > index cd176877..da4490b7 100755
> > --- a/tests/xfs/529
> > +++ b/tests/xfs/529
> > @@ -29,7 +29,8 @@ _require_xfs_io_error_injection "reduce_max_iextents"
> >  _require_xfs_io_error_injection "bmap_alloc_minlen_extent"
> >  
> >  echo "Format and mount fs"
> > -_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full
> > +_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount -o uquota >> $seqres.full
> >  
> >  # bmap_alloc_minlen_extent only applies to the datadev space allocator, so
> > diff --git a/tests/xfs/532 b/tests/xfs/532
> > index 74a7ac30..06e41367 100755
> > --- a/tests/xfs/532
> > +++ b/tests/xfs/532
> > @@ -26,7 +26,8 @@ _require_xfs_io_error_injection "reduce_max_iextents"
> >  _require_xfs_io_error_injection "bmap_alloc_minlen_extent"
> >  
> >  echo "Format and mount fs"
> > -_scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full
> > +_scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount >> $seqres.full
> >  
> >  # Disable realtime inherit flag (if any) on root directory so that space on data
> > diff --git a/tests/xfs/534 b/tests/xfs/534
> > index f17c45b8..bb940e4a 100755
> > --- a/tests/xfs/534
> > +++ b/tests/xfs/534
> > @@ -22,7 +22,8 @@ _require_xfs_io_command "falloc"
> >  _require_xfs_io_error_injection "reduce_max_iextents"
> >  
> >  echo "Format and mount fs"
> > -_scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full
> > +_scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount >> $seqres.full
> >  
> >  bsize=$(_get_file_block_size $SCRATCH_MNT)
> > diff --git a/tests/xfs/535 b/tests/xfs/535
> > index f76c1725..1c72e3a2 100755
> > --- a/tests/xfs/535
> > +++ b/tests/xfs/535
> > @@ -25,7 +25,8 @@ _require_xfs_io_command "funshare"
> >  _require_xfs_io_error_injection "reduce_max_iextents"
> >  
> >  echo "Format and mount fs"
> > -_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full
> > +_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount >> $seqres.full
> >  
> >  bsize=$(_get_block_size $SCRATCH_MNT)
> > diff --git a/tests/xfs/538 b/tests/xfs/538
> > index 0b5772a1..e8ac3918 100755
> > --- a/tests/xfs/538
> > +++ b/tests/xfs/538
> > @@ -23,7 +23,8 @@ _require_test_program "punch-alternating"
> >  _require_xfs_io_error_injection "bmap_alloc_minlen_extent"
> >  
> >  echo "Format and mount fs"
> > -_scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full
> > +_scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full \
> > +	|| _fail "mkfs failed"
> >  _scratch_mount >> $seqres.full
> >  
> >  # Disable realtime inherit flag (if any) on root directory so that space on data
> > -- 
> > 2.35.3
> > 
> > 
> 

