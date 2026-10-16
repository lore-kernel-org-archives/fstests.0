Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84709429803
	for <fstests@vger.kernel.org>; Fri, 16 Oct 2026 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187101; cv=none; b=Hs7QWeFbhsFrdjFUEQ+g73kSlMSk9VeOmPWJm92+Wi25uuQ22Q89Ljl2fxCHXntzOeuo9nDBIo0ZmM1QrN0729EhXombNTyUzgpU+U+oeiSTx2aGudwaUspW+7uS32By3Ybwx0bo+6Wf28GtmIf65+GrPedTkwZIaQXIBveZVmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187101; c=relaxed/simple;
	bh=mQDZ5Up432fUunQmPPmtzRXjrIQmGPACqnZ/tWr3JpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuI2y1jLDw77rSJBo6KQZKazDTmfoLS+95hlBqygE+IkEKsPFAfup33wyPdBhv8SmAG9dPUZvpRqm7hAJdHmIJeLKurPKlErF0Xzxl7UzM17D86uod8gSpwzgGisQ+WG+9uZT7QO5kVhKZ9zinT+iQLe1WdS8Hr5VCHjBxiTMPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EI4w7P0q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EI4w7P0q"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 190DE1F000C4;
	Fri, 16 Oct 2026 21:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792187099;
	bh=fi3/jpFVSgcCup5FXhemZ5nFZZTulCV+KP//RRcyIQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EI4w7P0qMPaklh1qh3pTHfIKo/q3rN/7cuEKUTb5/dliBjLwMaL381iquzkmCEI2k
	 Segu3VNLOHoMGHz+cv0UNDqHjhXEewIhEnBZUeAGT5ya+YkMY5zJNLlCaJd2f7D5wP
	 qNSKGGR1Zrg8niLipXBm0iS80W22SQC54kW7oQYz4LqtXyLOSo31Eokdib6wVVTgmA
	 ZeUzVWGOr00iDeegPlMfKCo4HZ+zYCrTJicZ2RFHH1DsyJ2UHvGljOmaAXTGkQHyOR
	 iDk5Y44e/BtUWnjHEGHCX5CLodunSEhtpU+0n0f/bkjIb10HFBm+si7WHyyb06Bfbj
	 mG7hMzkZIPdQQ==
Date: Fri, 16 Oct 2026 14:44:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>, Carlos Maiolino <cem@kernel.org>
Cc: fstests <fstests@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Zorro Lang <zlang@kernel.org>
Subject: many many fstests configurations [v2]
Message-ID: <20261016214458.GB107971@frogsfrogsfrogs>
References: <20261006182109.GP1615495@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006182109.GP1615495@frogsfrogsfrogs>

Ted mentioned the other day that my stupid scraper script left out
quite a few pieces of config data, so here's what I hope is the final
version of it.

> Here are my current fstests configurations for doing XFS QA and enough
> ext4/btrfs QA to check vfs changes.  Each non-comment non-blank line is
> a separate test config; you probably want to break that up and run them
> across a pile of VMs.
> 
> overnight.txt runs on my dev, for-next, and upstream branches.
> oci-mtr{,a}4* are my dev branch
> oci-mtr{,a}5* are the for-next branch
> oci-mtr{,a}6* are the upstream master
> ca*mtr* is my dev branch but it completes 3x faster
> 
> long-soak.txt runs just the soak tests on those three branches.
> oci-mtr{,a}7* are my dev branch
> oci-mtr{,a}8* are the for-next branch
> oci-mtr{,a}9* are the upstream master
> 
> --D

# /tmp/poot/ca-iodev-x92c-03-mtr00_2026-10-15_16-22-13_console.txt
TEST_DEV="/dev/sda" SCRATCH_DEV="/dev/sdf" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x recoveryloop,broken,dangerous_fuzzers,deprecated -e ext4/053

# /tmp/poot/ca-iodev-x92c-03-mtr03_2026-10-15_16-22-16_console.txt
TEST_DEV="/dev/pmem1" SCRATCH_DEV="/dev/pmem0" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d daxinherit=1," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x recoveryloop,broken,dangerous_fuzzers,deprecated -e ext4/053

# /tmp/poot/ca-iodev-x92c-03-mtr02_2026-10-15_16-22-13_console.txt
TEST_DEV="/dev/sdc" SCRATCH_DEV="/dev/sdb" MKFS_OPTIONS="-m uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x recoveryloop,broken,dangerous_fuzzers,deprecated -e ext4/053

# /tmp/poot/ca-iodev-x92c-03-mtr01_2026-10-15_16-22-14_console.txt
TEST_DEV="/dev/sde" SCRATCH_DEV="/dev/sdd" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -b size=1024," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x recoveryloop,broken,dangerous_fuzzers,deprecated -e ext4/053

# /tmp/poot/oci-mtra53_2026-10-14_00-21-20_console.txt
TEST_DEV="/dev/sdb2" SCRATCH_DEV="/dev/sdb3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="21m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_online_repair -x broken,dangerous_fuzzers,recoveryloop,deprecated -e ext4/053

# /tmp/poot/ca-nfsdev6-mtr03_2026-10-15_16-21-27_console.txt
TEST_DEV="/dev/pmem1" SCRATCH_DEV="/dev/pmem0" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d daxinherit=1," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x recoveryloop,broken,deprecated,dangerous_fuzzers -e ext4/053

# /tmp/poot/ca-nfsdev6-mtr01_2026-10-15_16-21-27_console.txt
TEST_DEV="/dev/sde" SCRATCH_DEV="/dev/sdd" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -b size=1024," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x recoveryloop,broken,deprecated,dangerous_fuzzers -e ext4/053

# /tmp/poot/oci-mtr5c_2026-10-14_00-22-31_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="2h" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g recoveryloop -x broken,deprecated,dangerous_fuzzers -e ext4/053

# /tmp/poot/oci-mtra55_2026-10-14_00-21-29_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="19.5m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_scrub -x recoveryloop,dangerous_fuzzers,broken,deprecated -e ext4/053

# /tmp/poot/ca-nfsdev6-mtr00_2026-10-15_16-21-28_console.txt
TEST_DEV="/dev/sda" SCRATCH_DEV="/dev/sdf" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -n size=8k," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x recoveryloop,broken,deprecated,dangerous_fuzzers -e ext4/053

# /tmp/poot/oci-mtr4c_2026-10-14_00-21-51_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="2h" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g recoveryloop -x dangerous_fuzzers,broken,deprecated -e ext4/053

# /tmp/poot/oci-mtr6i_2026-10-14_00-22-33_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-q" MOUNT_OPTIONS="-o x-fstests=fuse4fs" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="fuseblk.ext4" ./check -r -g all -x broken,recoveryloop,dangerous_fuzzers,deprecated -e ext4/053

# /tmp/poot/oci-mtr4j_2026-10-14_00-21-53_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-F -q" MOUNT_OPTIONS="-o x-fstests=kernel" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="ext4" ./check -r -g all -x dangerous_fuzzers,broken,deprecated,recoveryloop -e ext4/053

# /tmp/poot/oci-mtr4k_2026-10-14_00-22-22_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-q" MOUNT_OPTIONS="-o x-fstests=fuse4fs" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="fuseblk.ext4" ./check -r -g all -x dangerous_fuzzers,broken,deprecated,recoveryloop -e ext4/053

# /tmp/poot/oci-mtr4i_2026-10-14_00-21-47_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/loop2" SCRATCH_RTDEV="/dev/loop3" TEST_LOGDEV="/dev/loop4" SCRATCH_LOGDEV="/dev/loop5" TEST_DEV="/dev/loop0" SCRATCH_DEV="/dev/loop1" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1, -s size=4096," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x dangerous_fuzzers,broken,deprecated,recoveryloop -e ext4/053

# /tmp/poot/oci-mtra63_2026-10-14_00-21-43_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="22m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_online_repair -x broken,dangerous_fuzzers,recoveryloop,deprecated -e ext4/053

# /tmp/poot/oci-mtra56_2026-10-14_00-21-38_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="17.5m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_scrub -x recoveryloop,dangerous_fuzzers,broken,deprecated -e ext4/053

# /tmp/poot/oci-mtra44_2026-10-14_00-21-20_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="17.5m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_online_repair -x deprecated,recoveryloop,dangerous_fuzzers,broken -e ext4/053

# /tmp/poot/oci-mtra47_2026-10-14_00-21-13_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -b size=65536," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x deprecated,dangerous_fuzzers,broken,recoveryloop -e ext4/053

# /tmp/poot/oci-mtra64_2026-10-14_00-21-43_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="17.5m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_online_repair -x broken,dangerous_fuzzers,recoveryloop,deprecated -e ext4/053

# /tmp/poot/oci-mtra45_2026-10-14_00-21-20_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="20m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_scrub -x recoveryloop,dangerous_fuzzers,deprecated,broken -e ext4/053

# /tmp/poot/oci-mtra66_2026-10-14_00-21-33_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="15.5m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_scrub -x deprecated,broken,dangerous_fuzzers,recoveryloop -e ext4/053

# /tmp/poot/oci-mtra43_2026-10-14_00-21-42_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="20.5m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_online_repair -x deprecated,recoveryloop,dangerous_fuzzers,broken -e ext4/053

# /tmp/poot/oci-mtra54_2026-10-14_00-21-37_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="17.5m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_online_repair -x broken,dangerous_fuzzers,recoveryloop,deprecated -e ext4/053

# /tmp/poot/oci-mtra65_2026-10-14_00-21-36_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="20m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_scrub -x deprecated,broken,dangerous_fuzzers,recoveryloop -e ext4/053

# /tmp/poot/oci-mtra46_2026-10-14_00-21-13_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="15.5m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_scrub -x recoveryloop,dangerous_fuzzers,deprecated,broken -e ext4/053

# /tmp/poot/oci-mtra42_2026-10-14_00-21-36_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="2h" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g recoveryloop -x broken,deprecated,dangerous_fuzzers -e ext4/053

# /tmp/poot/oci-mtra52_2026-10-14_00-21-00_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="2h" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g recoveryloop -x broken,deprecated,dangerous_fuzzers -e ext4/053

# /tmp/poot/oci-mtr5b_2026-10-14_00-22-18_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_LOGDEV="/dev/sdb1" SCRATCH_LOGDEV="/dev/sdb2" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1, -r extsize=64k," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x deprecated,recoveryloop,broken,dangerous_fuzzers -e ext4/053

# /tmp/poot/oci-mtr4a_2026-10-14_00-21-56_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_LOGDEV="/dev/sdb1" SCRATCH_LOGDEV="/dev/sdb2" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x dangerous_fuzzers,broken,deprecated,recoveryloop -e ext4/053

# /tmp/poot/oci-mtr6f_2026-10-14_00-23-00_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="20m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_scrub -x deprecated,dangerous_fuzzers,recoveryloop,broken -e ext4/053

# /tmp/poot/oci-mtr64_2026-10-14_00-22-54_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x broken,recoveryloop,dangerous_fuzzers,deprecated -e ext4/053

# /tmp/poot/oci-mtr6g_2026-10-14_00-22-52_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="15.5m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_scrub -x deprecated,dangerous_fuzzers,recoveryloop,broken -e ext4/053

# /tmp/poot/oci-mtr69_2026-10-14_00-22-41_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV=" SP" MKFS_OPTIONS="/dev/sda4" MOUNT_OPTIONS="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="btrfs" ./check -r -g all -x broken,recoveryloop,dangerous_fuzzers,deprecated -e ext4/053

# /tmp/poot/oci-mtr5a_2026-10-14_00-22-22_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_LOGDEV="/dev/sdb1" SCRATCH_LOGDEV="/dev/sdb2" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x deprecated,recoveryloop,broken,dangerous_fuzzers -e ext4/053

# /tmp/poot/oci-mtr48_2026-10-14_00-22-17_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -b size=32768, -d rtinherit=1," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x dangerous_fuzzers,broken,deprecated,recoveryloop -e ext4/053

# /tmp/poot/oci-mtr59_2026-10-14_00-22-10_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -b size=32768," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x deprecated,recoveryloop,broken,dangerous_fuzzers -e ext4/053

# /tmp/poot/oci-mtr57_2026-10-14_00-22-11_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x deprecated,recoveryloop,broken,dangerous_fuzzers -e ext4/053

# /tmp/poot/oci-mtr44_2026-10-14_00-22-11_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x dangerous_fuzzers,broken,deprecated,recoveryloop -e ext4/053

# /tmp/poot/oci-mtr4g_2026-10-14_00-22-05_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="15.5m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_scrub -x broken,dangerous_fuzzers,recoveryloop,deprecated -e ext4/053

# /tmp/poot/oci-mtr4f_2026-10-14_00-21-56_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="19m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_scrub -x broken,dangerous_fuzzers,recoveryloop,deprecated -e ext4/053

# /tmp/poot/oci-mtr41_2026-10-14_00-21-53_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_LOGDEV="/dev/sdb1" SCRATCH_LOGDEV="/dev/sdb2" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1, -r extsize=28k," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x dangerous_fuzzers,broken,deprecated,recoveryloop -e ext4/053

# /tmp/poot/oci-mtr42_2026-10-14_00-21-52_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x dangerous_fuzzers,broken,deprecated,recoveryloop -e ext4/053

# /tmp/poot/oci-mtr51_2026-10-14_00-22-34_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_LOGDEV="/dev/sdb1" SCRATCH_LOGDEV="/dev/sdb2" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1, -r extsize=28k," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x deprecated,recoveryloop,broken,dangerous_fuzzers -e ext4/053

# /tmp/poot/oci-mtr5g_2026-10-14_00-22-28_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="15.5m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_scrub -x deprecated,dangerous_fuzzers,broken,recoveryloop -e ext4/053

# /tmp/poot/oci-mtr5f_2026-10-14_00-22-23_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="20m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_scrub -x deprecated,dangerous_fuzzers,broken,recoveryloop -e ext4/053

# /tmp/poot/oci-mtr5d_2026-10-14_00-22-24_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="21m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_online_repair -x recoveryloop,dangerous_fuzzers,broken,deprecated -e ext4/053

# /tmp/poot/oci-mtr6c_2026-10-14_00-22-35_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="2h" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g recoveryloop -x dangerous_fuzzers,deprecated,broken -e ext4/053

# /tmp/poot/oci-mtr53_2026-10-14_00-22-40_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m uquota,gquota,pquota, -d rtinherit=1, -n parent=0," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x deprecated,recoveryloop,broken,dangerous_fuzzers -e ext4/053

# /tmp/poot/oci-mtr61_2026-10-14_00-22-40_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_LOGDEV="/dev/sdb1" SCRATCH_LOGDEV="/dev/sdb2" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1, -r extsize=28k," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x broken,recoveryloop,dangerous_fuzzers,deprecated -e ext4/053

# /tmp/poot/oci-mtr62_2026-10-14_00-22-39_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x broken,recoveryloop,dangerous_fuzzers,deprecated -e ext4/053

# /tmp/poot/oci-mtra41_2026-10-14_00-20-59_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -b size=8192," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x deprecated,dangerous_fuzzers,broken,recoveryloop -e ext4/053

# /tmp/poot/oci-mtra40_2026-10-14_00-21-10_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x deprecated,dangerous_fuzzers,broken,recoveryloop -e ext4/053

# /tmp/poot/oci-mtra51_2026-10-14_00-21-38_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -b size=8192," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x recoveryloop,broken,deprecated,dangerous_fuzzers -e ext4/053

# /tmp/poot/oci-mtra62_2026-10-14_00-21-15_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="2h" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g recoveryloop -x dangerous_fuzzers,deprecated,broken -e ext4/053

# /tmp/poot/oci-mtra60_2026-10-14_00-21-11_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x broken,dangerous_fuzzers,deprecated,recoveryloop -e ext4/053

# /tmp/poot/oci-mtra50_2026-10-14_00-21-39_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x recoveryloop,broken,deprecated,dangerous_fuzzers -e ext4/053

# /tmp/poot/oci-mtra61_2026-10-14_00-21-25_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -b size=8192," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x broken,dangerous_fuzzers,deprecated,recoveryloop -e ext4/053

# /tmp/poot/oci-mtr4h_2026-10-14_00-21-49_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d su=128k,sw=4," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x dangerous_fuzzers,broken,deprecated,recoveryloop -e ext4/053

# /tmp/poot/oci-mtr66_2026-10-14_00-23-01_console.txt
USE_EXTERNAL=yes TEST_LOGDEV="/dev/sdb1" SCRATCH_LOGDEV="/dev/sdb2" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x broken,recoveryloop,dangerous_fuzzers,deprecated -e ext4/053

# /tmp/poot/oci-mtr4b_2026-10-14_00-21-45_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_LOGDEV="/dev/sdb1" SCRATCH_LOGDEV="/dev/sdb2" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1, -r extsize=64k," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x dangerous_fuzzers,broken,deprecated,recoveryloop -e ext4/053

# /tmp/poot/oci-mtr63_2026-10-14_00-22-40_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x broken,recoveryloop,dangerous_fuzzers,deprecated -e ext4/053

# /tmp/poot/oci-mtr67_2026-10-14_00-22-55_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x broken,recoveryloop,dangerous_fuzzers,deprecated -e ext4/053

# /tmp/poot/oci-mtr49_2026-10-14_00-22-12_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -b size=32768," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x dangerous_fuzzers,broken,deprecated,recoveryloop -e ext4/053

# /tmp/poot/oci-mtr46_2026-10-14_00-22-11_console.txt
USE_EXTERNAL=yes TEST_LOGDEV="/dev/sdb1" SCRATCH_LOGDEV="/dev/sdb2" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x dangerous_fuzzers,broken,deprecated,recoveryloop -e ext4/053

# /tmp/poot/oci-mtr6b_2026-10-14_00-22-37_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_LOGDEV="/dev/sdb1" SCRATCH_LOGDEV="/dev/sdb2" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1, -r extsize=64k," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x broken,recoveryloop,dangerous_fuzzers,deprecated -e ext4/053

# /tmp/poot/oci-mtr6a_2026-10-14_00-22-36_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_LOGDEV="/dev/sdb1" SCRATCH_LOGDEV="/dev/sdb2" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x broken,recoveryloop,dangerous_fuzzers,deprecated -e ext4/053

# /tmp/poot/oci-mtr58_2026-10-14_00-22-09_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1, -d rtinherit=1, -r zoned=1," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x deprecated,recoveryloop,broken,dangerous_fuzzers -e ext4/053

# /tmp/poot/oci-mtr68_2026-10-14_00-22-35_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-F -q" MOUNT_OPTIONS="-o x-fstests=kernel" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="ext4" ./check -r -g all -x broken,recoveryloop,dangerous_fuzzers,deprecated -e ext4/053

# /tmp/poot/oci-mtr6h_2026-10-14_00-22-43_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d su=128k,sw=4," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x broken,recoveryloop,dangerous_fuzzers,deprecated -e ext4/053

# /tmp/poot/oci-mtr47_2026-10-14_00-22-11_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x dangerous_fuzzers,broken,deprecated,recoveryloop -e ext4/053

# /tmp/poot/oci-mtr4d_2026-10-14_00-21-53_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="20m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_online_repair -x deprecated,dangerous_fuzzers,broken,recoveryloop -e ext4/053

# /tmp/poot/oci-mtr6d_2026-10-14_00-22-41_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="22m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_online_repair -x dangerous_fuzzers,broken,recoveryloop,deprecated -e ext4/053

# /tmp/poot/oci-mtr43_2026-10-14_00-21-55_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m metadir=0, -d rtinherit=1," MOUNT_OPTIONS="-o uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x dangerous_fuzzers,broken,deprecated,recoveryloop -e ext4/053

# /tmp/poot/oci-mtr4e_2026-10-14_00-21-53_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="17.5m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_online_repair -x deprecated,dangerous_fuzzers,broken,recoveryloop -e ext4/053

# /tmp/poot/oci-mtr52_2026-10-14_00-22-33_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1, -d rtinherit=1, -r zoned=1," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x deprecated,recoveryloop,broken,dangerous_fuzzers -e ext4/053

# /tmp/poot/oci-mtr54_2026-10-14_00-22-33_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x deprecated,recoveryloop,broken,dangerous_fuzzers -e ext4/053

# /tmp/poot/oci-mtr5e_2026-10-14_00-22-25_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="17.5m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_online_repair -x recoveryloop,dangerous_fuzzers,broken,deprecated -e ext4/053

# /tmp/poot/oci-mtr5h_2026-10-14_00-22-13_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d su=128k,sw=4," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x deprecated,recoveryloop,broken,dangerous_fuzzers -e ext4/053

# /tmp/poot/oci-mtr56_2026-10-14_00-22-13_console.txt
USE_EXTERNAL=yes TEST_LOGDEV="/dev/sdb1" SCRATCH_LOGDEV="/dev/sdb2" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x deprecated,recoveryloop,broken,dangerous_fuzzers -e ext4/053

# /tmp/poot/oci-mtr6e_2026-10-14_00-23-00_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="17.5m" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g fsstress_online_repair -x dangerous_fuzzers,broken,recoveryloop,deprecated -e ext4/053

# /tmp/poot/ca-nfsdev6-mtr02_2026-10-15_16-21-27_console.txt
TEST_DEV="/dev/sdc" SCRATCH_DEV="/dev/sdb" MKFS_OPTIONS="-m uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check -r -g all -x recoveryloop,broken,deprecated,dangerous_fuzzers -e ext4/053

# /tmp/toop/oci-mtra88_2026-10-06_01-50-42_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sda3" SCRATCH_RTDEV="/dev/sda4" TEST_DEV="/dev/sdb2" SCRATCH_DEV="/dev/sdb3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/286

# /tmp/toop/oci-mtra73_2026-10-06_01-50-33_console.txt
TEST_DEV="/dev/sdb2" SCRATCH_DEV="/dev/sdb3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/521

# /tmp/toop/oci-mtr92_2026-10-06_01-51-06_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/521

# /tmp/toop/oci-mtr74_2026-10-06_01-51-05_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/286

# /tmp/toop/oci-mtr99_2026-10-06_01-51-03_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1, -d rtinherit=1, -r zoned=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/522

# /tmp/toop/oci-mtr78_2026-10-06_01-50-55_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/286

# /tmp/toop/oci-mtr91_2026-10-06_01-50-53_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/286

# /tmp/toop/oci-mtr79_2026-10-06_01-50-53_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/522

# /tmp/toop/oci-mtr89_2026-10-06_01-50-24_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/285

# /tmp/toop/oci-mtr80_2026-10-06_01-50-20_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/285

# /tmp/toop/oci-mtr85_2026-10-06_01-50-15_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/521

# /tmp/toop/oci-mtr76_2026-10-06_01-49-59_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/285

# /tmp/toop/oci-mtr81_2026-10-06_01-49-52_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/388

# /tmp/toop/oci-mtr86_2026-10-06_01-49-40_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/286

# /tmp/toop/oci-mtr71_2026-10-06_01-50-35_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/522

# /tmp/toop/oci-mtr93_2026-10-06_01-50-41_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/285

# /tmp/toop/oci-mtr97_2026-10-06_01-50-43_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1, -d rtinherit=1, -r zoned=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/285

# /tmp/toop/oci-mtr70_2026-10-06_01-50-40_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/521

# /tmp/toop/oci-mtr72_2026-10-06_01-50-47_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/476

# /tmp/toop/oci-mtra98_2026-10-06_01-51-32_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1, -d rtinherit=1, -r zoned=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/285

# /tmp/toop/oci-mtra74_2026-10-06_01-51-25_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/285

# /tmp/toop/oci-mtra77_2026-10-06_01-51-15_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/286

# /tmp/toop/oci-mtra99_2026-10-06_01-51-14_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1, -d rtinherit=1, -r zoned=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/522

# /tmp/toop/oci-mtra93_2026-10-06_01-51-06_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/285

# /tmp/toop/oci-mtra90_2026-10-06_01-51-06_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/521

# /tmp/toop/oci-mtra95_2026-10-06_01-50-52_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/522

# /tmp/toop/oci-mtra79_2026-10-06_01-50-27_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/285

# /tmp/toop/oci-mtra83_2026-10-06_01-50-23_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/476

# /tmp/toop/oci-mtra76_2026-10-06_01-51-04_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/522

# /tmp/toop/oci-mtra94_2026-10-06_01-50-56_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/286

# /tmp/toop/oci-mtra84_2026-10-06_01-49-48_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/285

# /tmp/toop/oci-mtra92_2026-10-06_01-50-33_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/388

# /tmp/toop/oci-mtra70_2026-10-06_01-50-24_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/388

# /tmp/toop/oci-mtra82_2026-10-06_01-50-04_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/521

# /tmp/toop/oci-mtra91_2026-10-06_01-50-52_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/476

# /tmp/toop/oci-mtra89_2026-10-06_01-50-25_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/522

# /tmp/toop/oci-mtra71_2026-10-06_01-50-21_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/286

# /tmp/toop/oci-mtra75_2026-10-06_01-50-52_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/522

# /tmp/toop/oci-mtra87_2026-10-06_01-50-42_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/285

# /tmp/toop/oci-mtra72_2026-10-06_01-50-12_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/476

# /tmp/toop/oci-mtra81_2026-10-06_01-50-21_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/286

# /tmp/toop/oci-mtra85_2026-10-06_01-50-14_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/388

# /tmp/toop/oci-mtra86_2026-10-06_01-50-21_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/521

# /tmp/toop/oci-mtra80_2026-10-06_01-49-51_console.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/522

# /tmp/toop/oci-mtra97_2026-10-06_01-50-55_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1, -d rtinherit=1, -r zoned=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/286

# /tmp/toop/oci-mtra78_2026-10-06_01-50-34_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/521

# /tmp/toop/oci-mtra96_2026-10-06_01-51-11_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1, -d rtinherit=1, -r zoned=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/521

# /tmp/toop/oci-mtr82_2026-10-06_01-49-46_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/286

# /tmp/toop/oci-mtr77_2026-10-06_01-50-28_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/521

# /tmp/toop/oci-mtr73_2026-10-06_01-50-09_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/388

# /tmp/toop/oci-mtr96_2026-10-06_01-50-59_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1, -d rtinherit=1, -r zoned=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/521

# /tmp/toop/oci-mtr83_2026-10-06_01-49-41_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/476

# /tmp/toop/oci-mtr84_2026-10-06_01-50-33_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/522

# /tmp/toop/oci-mtr88_2026-10-06_01-50-59_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/521

# /tmp/toop/oci-mtr90_2026-10-06_01-50-30_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/388

# /tmp/toop/oci-mtr98_2026-10-06_01-51-03_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1, -d rtinherit=1, -r zoned=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/286

# /tmp/toop/oci-mtr94_2026-10-06_01-50-51_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/522

# /tmp/toop/oci-mtr87_2026-10-06_01-50-20_console.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d rtinherit=1," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/522

# /tmp/toop/oci-mtr75_2026-10-06_01-50-07_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check xfs/285

# /tmp/toop/oci-mtr95_2026-10-06_01-52-02_console.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s FSTYP="xfs" ./check generic/476
