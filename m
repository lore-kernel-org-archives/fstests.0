Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D952F2E6106
	for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750438401; cv=none; b=X5FeQ3+25gA3VGDx7cif9DPV5SA07FPDtizTCqK4RHcFEdIFvas1z9at7vUgZaGH61aL3ax5RdxOc4DmFm6UVlQviyXkS8s8GjDSF8spobFMos7ktHZAh8/BqixHbWwlSOLy9SPUgLmPyidmSAQwCBebh48QvF/2SArZ+kPGr7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750438401; c=relaxed/simple;
	bh=1jVLi3S5e19TpmXKxD6UgYR4cw/Ec1svf3y1EQwGUAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ3MmwFImE68EM8ddrR5Uqrn5kwFUTXNrNhwHE7oXMs/5gWxPrrehyVK6/bldoLKlqmkt7AB1CABcLwaSM4f3eD5TlQBF0bDgh++1kKWOVRSNBL8TMaCMw5J8clitQwX7M6ufR8/RBk/toZUkp7E73LFVNtPKmQecoqMq9lAvkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKiZdLjB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKiZdLjB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750438397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dYAPPNTXeSvPI88IQL8BbpWdegPcTOfSi43106pMmQU=;
	b=iKiZdLjBxEIxLFRsMzOTEB3YTPJzDzwYGc8lJhPwmrb9mCgZT3hBY4nRdck11MBPf/BqPX
	sBjYJlKRgNCFb8V31uJtxcy/SqGiSPHf3MYoiPQAz8KC7lMiqYVdNN7MCAmUGBBo5rnWGv
	Ays/Le/7Bop8mpxrinoKydaEoiOZAZM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-ltT7WqT8N5-EHzG9DEz0uA-1; Fri, 20 Jun 2025 12:53:16 -0400
X-MC-Unique: ltT7WqT8N5-EHzG9DEz0uA-1
X-Mimecast-MFC-AGG-ID: ltT7WqT8N5-EHzG9DEz0uA_1750438395
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-231d13ac4d4so28723245ad.3
        for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 09:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750438395; x=1751043195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYAPPNTXeSvPI88IQL8BbpWdegPcTOfSi43106pMmQU=;
        b=jYGoNw6TdfyUY4ipza+GroIVeb58L6Vg+PUB1MW9C+2yA1gCRs5FCK6tFP1uv2KBxS
         T1nCH7rH7IG+X/AdIu3FF+jnKVTp338x+ZPUzKXO7x0ctW3rPzSx3QlKvV25cILGwAMz
         fjqgOlzGh+bYMMTpu6hTBF+qBI9LUNT4eTVMYPc1g5nSY9l0mpUAfDzTKt2uQ4eHvMML
         ho5kXMkmvVQOXovUNrXidSM7dGO2nyn9A55G7Qh/QCo2dar5zU7qDJ+qFAKMzpUfozik
         I/Yfk0uD7p1Fiaeq6E/4JxDbHdTmQ6fg0UAf59pxG8y0qJbD4d1JNfXLlJqjUVn5R94O
         JenQ==
X-Gm-Message-State: AOJu0YzVKI4kcIy7RKM+QEE1xTypyHlg3VMLvPzfy1eogrv4Yv+lq0OG
	HfLbJ6pyzN5t02h61T9xejE45sQ2FqIvvydghX6b65FJUggjBLMpj//F3udAahY9/37UpI7yVZd
	/wOdp5gLQmmxmzrvqvyZ2y4utVP0yn5cjaxl5rEgYnoiMpY7XWzobyHhzADU=
X-Gm-Gg: ASbGncs2q3QXoRK3GyG1hQAVmLvca9PuIDO+UVv2FEGhpnquc8IT70IalPNpp+eSN54
	lf8aEYV2B9nfF5lq13dr4wmhx0+jKPodBzQVHv0itRNDDwP6OhMWMaoAwqBhs20okelPlrITahY
	nmN/3ne16LF7kwgQPQKsCjwrtC4QxFOSaF1cY2eEG5KLK+7l2nTx8+Lk/UEV6vai8wCDUSi9zSD
	rdFFsfg/Xz4ukrFelDARdGlLWkKRbLESXp9gSU5tzCX/g6DXmepLKTRvVru/CAg1Y2oXPhSTmUG
	UrjO/sHmCxaMX7q5hz6k7L5S055WbEosL3sNDwZOAzNWGs2npDACxdw4ny+VDEs=
X-Received: by 2002:a17:902:e844:b0:235:e96b:191c with SMTP id d9443c01a7336-237d9917055mr64994375ad.29.1750438395184;
        Fri, 20 Jun 2025 09:53:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECGhN+KvjMlvCEWsCbPj4v44fQAOBvznmrjgMDwEMnpR/GWISeiVMuKyj2ab35vDMwAGvZng==
X-Received: by 2002:a17:902:e844:b0:235:e96b:191c with SMTP id d9443c01a7336-237d9917055mr64993995ad.29.1750438394773;
        Fri, 20 Jun 2025 09:53:14 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d860a36dsm21698885ad.126.2025.06.20.09.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 09:53:14 -0700 (PDT)
Date: Sat, 21 Jun 2025 00:53:10 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com
Subject: Re: [RFC 09/12] ext4/061: Atomic writes stress test for bigalloc
 using fio crc verifier
Message-ID: <20250620165310.g3qv46n7ai257cem@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <1fb9171017c601c3a1e1da1581d5da41746ca813.1749629233.git.ojaswin@linux.ibm.com>
 <20250619074351.6tyynxkbzkzjmjub@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aFV5RCqvEylNTOVt@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFV5RCqvEylNTOVt@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Fri, Jun 20, 2025 at 08:38:40PM +0530, Ojaswin Mujoo wrote:
> On Thu, Jun 19, 2025 at 03:43:51PM +0800, Zorro Lang wrote:
> > On Wed, Jun 11, 2025 at 03:04:52PM +0530, Ojaswin Mujoo wrote:
> > > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > > 
> > > We brute force all possible blocksize & clustersize combinations on
> > > a bigalloc filesystem for stressing atomic write using fio data crc
> > > verifier. We run nproc * $LOAD_FACTOR threads in parallel writing to
> > > a single $SCRATCH_MNT/test-file. With atomic writes this test ensures
> > > that we never see the mix of data contents from different threads on
> > > a given bsrange.
> > > 
> > > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > ---
> > >  tests/ext4/061     | 107 +++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/ext4/061.out |   2 +
> > >  2 files changed, 109 insertions(+)
> > >  create mode 100755 tests/ext4/061
> > >  create mode 100644 tests/ext4/061.out
> > > 
> 
> <snip>
> 
> > > +function max()
> > > +{
> > > +	if (( $1 > $2 )); then
> > > +		echo "$1"
> > > +	else
> > > +		echo "$2"
> > > +	fi
> > > +}
> > > +
> > > +function min()
> > > +{
> > > +	if (( $1 < $2 )); then
> > > +		echo "$1"
> > > +	else
> > > +		echo "$2"
> > > +	fi
> > > +}
> > 
> > I've seen these two functions many times, please make them to be common helpers.
> 
> Yes I will do this in v2.
> 
> > 
> > > +
> > > +FS_MAX_CLUSTER_SIZE=$((128*1024))
> > > +FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
> > > +SIZE=$((100*1024*1024))
> > > +fiobsize=4096
> > > +
> > > +# Calculate fsblocksize and FS_MAX_CLUSTER_SIZE as per bdev atomic write units.
> > > +bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
> > > +bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
> > > +fsblocksize=$(max 4096 "$bdev_awu_min")
> > > +FS_MAX_CLUSTER_SIZE=$(min "$FS_MAX_CLUSTER_SIZE" "$bdev_awu_max")
> > > +
> > > +function create_fio_config()
> > > +{
> > > +cat >$fio_config <<EOF
> > > +	[aio-dio-aw-verify]
> > > +	direct=1
> > > +	ioengine=libaio
> > 
> > _require_aiodio
> 
> Got it, thanks
> > 
> > > +	rw=randwrite
> > > +	bs=$fiobsize
> > > +	fallocate=native
> > > +	filename=$SCRATCH_MNT/test-file
> > > +	size=$SIZE
> > > +	iodepth=$FIO_LOAD
> > > +	numjobs=$FIO_LOAD
> > > +	group_reporting=1
> > > +	verify_state_save=0
> > > +	verify=crc32c
> > > +	verify_fatal=1
> > > +	verify_dump=0
> > > +	verify_backlog=1024
> > > +	verify_async=4
> > > +	verify_write_sequence=0
> > > +	atomic=1
> > > +EOF
> > > +}
> > > +
> > > +# Let's create a sample fio config to check whether fio supports all options.
> > > +fio_config=$tmp.fio
> > > +create_fio_config
> > > +_require_fio $fio_config
> > > +
> > > +for ((fsblocksize=$fsblocksize; fsblocksize <= $(_get_page_size); fsblocksize = $fsblocksize << 1)); do
> > > +	for ((fsclustersize=$fsblocksize; fsclustersize <= $FS_MAX_CLUSTER_SIZE; fsclustersize = $fsclustersize << 1)); do
> > > +		for ((fiobsize = $fsblocksize; fiobsize <= $fsclustersize; fiobsize = $fiobsize << 1)); do
> > 
> > Wow, 3 for loops...
> 
> Yes :) We want to test all the combinations. Since the IO is less, it
> usually finishes within a reasonable time (~5 mins)
> 
> > 
> > > +			MKFS_OPTIONS="-O bigalloc -b $fsblocksize -C $fsclustersize"
> > > +			_scratch_mkfs_ext4 "$MKFS_OPTIONS" >> $seqres.full 2>&1 || continue
> > 
> > MKFS_OPTIONS is used in _scratch_mkfs_ext4 by default, you don't need to use it as
> > an argument.
> > 
> > Or do you want to do:
> > 
> > _scratch_mkfs_ext4 "-O bigalloc -b $fsblocksize -C $fsclustersize" ?
> 
> Yes we want to explicitly run these options so various block and cluster
> sizes get tested irrespective of what the user passes in MKFS_OPTIONS.
> 
> However, looking at _scratch_mkfs_ext4() > _scratch_do_mkfs() we seem
> to try mkfs.ext4 $MKFS_OPTIONS $extra_mkfs_options first and if that fails we 
> anyways try mkfs $extra_mkfs_options.
> 
> That being said, I'm a bit unsure whether something like:
> 
> mkfs.ext4 $MKFS_OPTIONS -O bigalloc -b $fsblocksize -C $fsclustersize
> 
> would produce reliable results always so:
> 
> 		MKFS_OPTIONS="-O bigalloc -b $fsblocksize -C $fsclustersize"
> 		_scratch_mkfs_ext4
> 
> seems better approach. Thoughts?

Sure, this's good to me:)

Thanks,
Zorro

> 
> > 
> > > +			if _try_scratch_mount >> $seqres.full 2>&1; then
> > > +				touch $SCRATCH_MNT/f1
> > > +				echo "== FIO test for fsblocksize=$fsblocksize fsclustersize=$fsclustersize fiobsize=$fiobsize ==" >> $seqres.full
> > > +				fio_config=$tmp.fio
> > 
> > Do you change the "$tmp"? If not, you don't need to set fio_config=$tmp.fio
> > everytime, you've set fio_config above this for loop.
> > 
> > > +				fio_out=$tmp.fio.out
> > 
> > If you don't change "$tmp", you can set fio_out once, before the
> > for loop running.
> > 
> > > +				create_fio_config
> > > +				_require_fio $fio_config
> > 
> > I think only $fiobsize will be changed in $fio_config at here, so you're trying
> > to check "bs=$fiobsize"? If so, that doesn't make sense, due to _require_fio accepts
> > any "bs" number, except bs <= 0. So you don't need to call _require_fio
> > at here everytime, especially you've called it before the loop running.
> > 
> 
> Makes sense, I'll clean this up.
> 
> Thanks,
> ojaswin
> 
> > Thanks,
> > Zorro
> > 
> > > +				cat $fio_config >> $seqres.full
> > > +				$FIO_PROG $fio_config --output=$fio_out
> > > +				ret=$?
> > > +				cat $fio_out >> $seqres.full
> > > +				_scratch_unmount
> > > +				[[ $ret -eq 0 ]] || break;
> > > +			fi
> > > +		done
> > > +	done
> > > +done
> > > +
> > > +# success, all done
> > > +echo Silence is golden
> > > +status=0
> > > +exit
> > > diff --git a/tests/ext4/061.out b/tests/ext4/061.out
> > > new file mode 100644
> > > index 00000000..273be9e0
> > > --- /dev/null
> > > +++ b/tests/ext4/061.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 061
> > > +Silence is golden
> > > -- 
> > > 2.49.0
> > > 
> > > 
> > 
> 

