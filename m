Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A664A3878
	for <fstests@vger.kernel.org>; Tue,  6 Oct 2026 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310872; cv=none; b=IPhHGRRvIcmZuwUOOMXJZF+XsXH3rHEyh8Jlcv3hI6m4pThFY5g1qS4e7BJMNXFwzNw4N61LMCiRDIJM4YJgH91nh48/QhrkY0+ek8PGT4U7K7gF1k5l/U12t6zTbMb8OY2SIjRycQPmUw2onUHb1x0+0axOhJfYGDf9z+4WTT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310872; c=relaxed/simple;
	bh=wSO2LYeuYj6byBgaQD+akjEpkz5qtHLYBJZWfE24Z1o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=thYwUNCbvnFBnlnGY41aV8VeO/HJcvVgynL8M5EzOc94GCoptPn/h5Pac/MRJTOnUxG22gKIZB2AMNdvrt9vigO9XfvXR7zQ0N/0PqhvbWmCiQFDrwHhB6HVaOHXdSDLabAWl4ASUOCIwU7QB8gpGLdTItWbByQkbS6bNupUNhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEX+EJ93; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEX+EJ93"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7EA671F0089B;
	Tue,  6 Oct 2026 18:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791310869;
	bh=pKjKIhRKEFsIdQhtCdZs3K9gBh+FedKpf7enY260OGs=;
	h=Date:From:To:Cc:Subject;
	b=hEX+EJ93WQJ4YlxnXVdZjqP64TUa1sJJOaqtjxSWNomaCXbzx32+xnyt84lZ4oCyQ
	 gKKxDkY2xZfQnd0olgzs6wFJCGbf2F3i2ZpltC29Gs1pkvfGRkADWElEonGU/Zy1y4
	 0w7my6LqVn0YINKt/4sAKNnYymIJ8vHdMS2ywteT0gvH/1DeK1h39Egc4qe33/3qUn
	 79fUw+AZwfkBvE7YXc9vJXUVzAyEnxC1w3Iri0mciZaPQ1MNVpZ7Ej3V+0+v45GsEP
	 aghUd0jnOkMw9qcS+yLfSVPCmiEIZOPjWOoNauKj8yKLTji0Fin6alsGSDs7JqHaQY
	 W6vA750kNiHLw==
Date: Tue, 6 Oct 2026 11:21:09 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>, Carlos Maiolino <cem@kernel.org>
Cc: fstests <fstests@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Zorro Lang <zlang@kernel.org>
Subject: many many fstests configurations
Message-ID: <20261006182109.GP1615495@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="77mP7Vjph+AGzl4C"
Content-Disposition: inline


--77mP7Vjph+AGzl4C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey, since you guys asked,

Here are my current fstests configurations for doing XFS QA and enough
ext4/btrfs QA to check vfs changes.  Each non-comment non-blank line is
a separate test config; you probably want to break that up and run them
across a pile of VMs.

overnight.txt runs on my dev, for-next, and upstream branches.
oci-mtr{,a}4* are my dev branch
oci-mtr{,a}5* are the for-next branch
oci-mtr{,a}6* are the upstream master
ca*mtr* is my dev branch but it completes 3x faster

long-soak.txt runs just the soak tests on those three branches.
oci-mtr{,a}7* are my dev branch
oci-mtr{,a}8* are the for-next branch
oci-mtr{,a}9* are the upstream master

--D

--77mP7Vjph+AGzl4C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="overnight.txt"

# /storage/mtr/tmp/logs/mtr-do/ca-nfsdev6-mtr00.txt
TEST_DEV="/dev/sda" SCRATCH_DEV="/dev/sdf" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -n size=8k," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x deprecated,dangerous_fuzzers,broken,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/ca-nfsdev6-mtr01.txt
TEST_DEV="/dev/sde" SCRATCH_DEV="/dev/sdd" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -b size=1024," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x deprecated,dangerous_fuzzers,broken,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/ca-nfsdev6-mtr02.txt
TEST_DEV="/dev/sdc" SCRATCH_DEV="/dev/sdb" MKFS_OPTIONS="-m uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x deprecated,dangerous_fuzzers,broken,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/ca-nfsdev6-mtr03.txt
TEST_DEV="/dev/pmem1" SCRATCH_DEV="/dev/pmem0" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d daxinherit=1," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x deprecated,dangerous_fuzzers,broken,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr40.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x broken,recoveryloop,dangerous_fuzzers,deprecated -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr41.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x deprecated,recoveryloop,dangerous_fuzzers,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr42.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x deprecated,recoveryloop,dangerous_fuzzers,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr43.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MOUNT_OPTIONS="-o uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x deprecated,recoveryloop,dangerous_fuzzers,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr44.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x deprecated,recoveryloop,dangerous_fuzzers,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr45.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -n size=8192," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x broken,recoveryloop,dangerous_fuzzers,deprecated -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr46.txt
USE_EXTERNAL=yes TEST_LOGDEV="/dev/sdb1" SCRATCH_LOGDEV="/dev/sdb2" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x deprecated,recoveryloop,dangerous_fuzzers,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr47.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x deprecated,recoveryloop,dangerous_fuzzers,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr48.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x deprecated,recoveryloop,dangerous_fuzzers,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr49.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -b size=32768," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x deprecated,recoveryloop,dangerous_fuzzers,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr4a.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x deprecated,recoveryloop,dangerous_fuzzers,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr4b.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x deprecated,recoveryloop,dangerous_fuzzers,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr4c.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g recoveryloop -x dangerous_fuzzers,broken,deprecated -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr4d.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_online_repair -x deprecated,dangerous_fuzzers,recoveryloop,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr4e.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_online_repair -x deprecated,dangerous_fuzzers,recoveryloop,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr4f.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_scrub -x dangerous_fuzzers,recoveryloop,broken,deprecated -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr4g.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_scrub -x dangerous_fuzzers,recoveryloop,broken,deprecated -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr4h.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d su=128k,sw=4," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x deprecated,recoveryloop,dangerous_fuzzers,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr4i.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/loop2" SCRATCH_RTDEV="/dev/loop3" TEST_DEV="/dev/loop0" SCRATCH_DEV="/dev/loop1" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x deprecated,recoveryloop,dangerous_fuzzers,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr4j.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-F -q" MOUNT_OPTIONS="-o x-fstests=kernel" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x deprecated,recoveryloop,dangerous_fuzzers,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr4k.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-q" MOUNT_OPTIONS="-o x-fstests=fuse4fs" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x deprecated,recoveryloop,dangerous_fuzzers,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr50.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x recoveryloop,dangerous_fuzzers,deprecated,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr51.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x recoveryloop,dangerous_fuzzers,deprecated,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr52.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x recoveryloop,dangerous_fuzzers,deprecated,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr53.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x recoveryloop,dangerous_fuzzers,deprecated,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr54.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x recoveryloop,dangerous_fuzzers,deprecated,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr55.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -n size=8192," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x recoveryloop,dangerous_fuzzers,deprecated,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr56.txt
USE_EXTERNAL=yes TEST_LOGDEV="/dev/sdb1" SCRATCH_LOGDEV="/dev/sdb2" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x recoveryloop,dangerous_fuzzers,deprecated,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr57.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x recoveryloop,dangerous_fuzzers,deprecated,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr58.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1, -d rtinherit=1, -r zoned=1," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x recoveryloop,dangerous_fuzzers,deprecated,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr59.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -b size=32768," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x recoveryloop,dangerous_fuzzers,deprecated,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr5a.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x recoveryloop,dangerous_fuzzers,deprecated,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr5b.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x recoveryloop,dangerous_fuzzers,deprecated,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr5c.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g recoveryloop -x broken,deprecated,dangerous_fuzzers -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr5d.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_online_repair -x deprecated,broken,dangerous_fuzzers,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr5e.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_online_repair -x deprecated,broken,dangerous_fuzzers,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr5f.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_scrub -x broken,dangerous_fuzzers,recoveryloop,deprecated -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr5g.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_scrub -x broken,dangerous_fuzzers,recoveryloop,deprecated -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr5h.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d su=128k,sw=4," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x recoveryloop,dangerous_fuzzers,deprecated,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr5i.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-F -q" MOUNT_OPTIONS="-o iomap=1" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x broken -e generic/046,ext4/053,generic/044

# /storage/mtr/tmp/logs/mtr-do/oci-mtr5j.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-F -q" MOUNT_OPTIONS="-o iomap=1  /opt" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x broken -e generic/044,ext4/053,generic/046

# /storage/mtr/tmp/logs/mtr-do/oci-mtr60.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x broken,deprecated,dangerous_fuzzers,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr61.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x broken,dangerous_fuzzers,deprecated,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr62.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x broken,dangerous_fuzzers,deprecated,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr63.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x broken,dangerous_fuzzers,deprecated,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr64.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x broken,dangerous_fuzzers,deprecated,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr65.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -n size=8192," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x broken,deprecated,dangerous_fuzzers,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr66.txt
USE_EXTERNAL=yes TEST_LOGDEV="/dev/sdb1" SCRATCH_LOGDEV="/dev/sdb2" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x broken,dangerous_fuzzers,deprecated,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr67.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x broken,dangerous_fuzzers,deprecated,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr68.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-F -q" MOUNT_OPTIONS="-o x-fstests=kernel" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x broken,dangerous_fuzzers,deprecated,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr69.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV=" SP" MKFS_OPTIONS="/dev/sda4" MOUNT_OPTIONS="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x broken,dangerous_fuzzers,deprecated,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr6a.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x broken,dangerous_fuzzers,deprecated,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr6b.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x broken,dangerous_fuzzers,deprecated,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr6c.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g recoveryloop -x dangerous_fuzzers,broken,deprecated -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr6d.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_online_repair -x broken,dangerous_fuzzers,recoveryloop,deprecated -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr6e.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_online_repair -x broken,dangerous_fuzzers,recoveryloop,deprecated -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr6f.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_scrub -x broken,deprecated,recoveryloop,dangerous_fuzzers -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr6g.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_scrub -x broken,deprecated,recoveryloop,dangerous_fuzzers -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr6h.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -d su=128k,sw=4," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x broken,dangerous_fuzzers,deprecated,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtr6i.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-q" MOUNT_OPTIONS="-o x-fstests=fuse4fs" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x broken,dangerous_fuzzers,deprecated,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra40.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x dangerous_fuzzers,broken,recoveryloop,deprecated -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra41.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -b size=8192," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x dangerous_fuzzers,broken,recoveryloop,deprecated -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra42.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g recoveryloop -x dangerous_fuzzers,deprecated,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra43.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_online_repair -x deprecated,broken,dangerous_fuzzers,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra44.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_online_repair -x deprecated,broken,dangerous_fuzzers,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra45.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_scrub -x recoveryloop,deprecated,broken,dangerous_fuzzers -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra46.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_scrub -x recoveryloop,deprecated,broken,dangerous_fuzzers -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra47.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -b size=65536," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x dangerous_fuzzers,broken,recoveryloop,deprecated -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra50.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x broken,recoveryloop,dangerous_fuzzers,deprecated -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra51.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -b size=8192," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x broken,recoveryloop,dangerous_fuzzers,deprecated -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra52.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g recoveryloop -x broken,deprecated,dangerous_fuzzers -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra53.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_online_repair -x recoveryloop,broken,deprecated,dangerous_fuzzers -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra54.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_online_repair -x recoveryloop,broken,deprecated,dangerous_fuzzers -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra55.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_scrub -x recoveryloop,dangerous_fuzzers,deprecated,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra56.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_scrub -x recoveryloop,dangerous_fuzzers,deprecated,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra60.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x deprecated,dangerous_fuzzers,broken,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra61.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota, -b size=8192," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g all -x deprecated,dangerous_fuzzers,broken,recoveryloop -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra62.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g recoveryloop -x broken,dangerous_fuzzers,deprecated -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra63.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_online_repair -x deprecated,dangerous_fuzzers,recoveryloop,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra64.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_online_repair -x deprecated,dangerous_fuzzers,recoveryloop,broken -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra65.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_scrub -x recoveryloop,broken,dangerous_fuzzers,deprecated -e ext4/053

# /storage/mtr/tmp/logs/mtr-do/oci-mtra66.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check -r -g fsstress_scrub -x recoveryloop,broken,dangerous_fuzzers,deprecated -e ext4/053


--77mP7Vjph+AGzl4C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="long-soak.txt"

# /storage/mtr/tmp/logs/mtr-do/oci-mtr70.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/521

# /storage/mtr/tmp/logs/mtr-do/oci-mtr71.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/522

# /storage/mtr/tmp/logs/mtr-do/oci-mtr72.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/476

# /storage/mtr/tmp/logs/mtr-do/oci-mtr73.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/388

# /storage/mtr/tmp/logs/mtr-do/oci-mtr74.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/286

# /storage/mtr/tmp/logs/mtr-do/oci-mtr75.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/285

# /storage/mtr/tmp/logs/mtr-do/oci-mtr76.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/285

# /storage/mtr/tmp/logs/mtr-do/oci-mtr77.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/521

# /storage/mtr/tmp/logs/mtr-do/oci-mtr78.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/286

# /storage/mtr/tmp/logs/mtr-do/oci-mtr79.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/522

# /storage/mtr/tmp/logs/mtr-do/oci-mtr80.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/285

# /storage/mtr/tmp/logs/mtr-do/oci-mtr81.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/388

# /storage/mtr/tmp/logs/mtr-do/oci-mtr82.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/286

# /storage/mtr/tmp/logs/mtr-do/oci-mtr83.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/476

# /storage/mtr/tmp/logs/mtr-do/oci-mtr84.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/522

# /storage/mtr/tmp/logs/mtr-do/oci-mtr85.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/521

# /storage/mtr/tmp/logs/mtr-do/oci-mtr86.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/286

# /storage/mtr/tmp/logs/mtr-do/oci-mtr87.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/522

# /storage/mtr/tmp/logs/mtr-do/oci-mtr88.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/521

# /storage/mtr/tmp/logs/mtr-do/oci-mtr89.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/285

# /storage/mtr/tmp/logs/mtr-do/oci-mtr90.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/388

# /storage/mtr/tmp/logs/mtr-do/oci-mtr91.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/286

# /storage/mtr/tmp/logs/mtr-do/oci-mtr92.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/521

# /storage/mtr/tmp/logs/mtr-do/oci-mtr93.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/285

# /storage/mtr/tmp/logs/mtr-do/oci-mtr94.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/522

# /storage/mtr/tmp/logs/mtr-do/oci-mtr95.txt
TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/476

# /storage/mtr/tmp/logs/mtr-do/oci-mtr96.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/521

# /storage/mtr/tmp/logs/mtr-do/oci-mtr97.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/285

# /storage/mtr/tmp/logs/mtr-do/oci-mtr98.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/286

# /storage/mtr/tmp/logs/mtr-do/oci-mtr99.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda3" SCRATCH_DEV="/dev/sda4" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/522

# /storage/mtr/tmp/logs/mtr-do/oci-mtra70.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/388

# /storage/mtr/tmp/logs/mtr-do/oci-mtra71.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/286

# /storage/mtr/tmp/logs/mtr-do/oci-mtra72.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/476

# /storage/mtr/tmp/logs/mtr-do/oci-mtra73.txt
TEST_DEV="/dev/sdb2" SCRATCH_DEV="/dev/sdb3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/521

# /storage/mtr/tmp/logs/mtr-do/oci-mtra74.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/285

# /storage/mtr/tmp/logs/mtr-do/oci-mtra75.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/522

# /storage/mtr/tmp/logs/mtr-do/oci-mtra76.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/522

# /storage/mtr/tmp/logs/mtr-do/oci-mtra77.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/286

# /storage/mtr/tmp/logs/mtr-do/oci-mtra78.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/521

# /storage/mtr/tmp/logs/mtr-do/oci-mtra79.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/285

# /storage/mtr/tmp/logs/mtr-do/oci-mtra80.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/522

# /storage/mtr/tmp/logs/mtr-do/oci-mtra81.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/286

# /storage/mtr/tmp/logs/mtr-do/oci-mtra82.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/521

# /storage/mtr/tmp/logs/mtr-do/oci-mtra83.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/476

# /storage/mtr/tmp/logs/mtr-do/oci-mtra84.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/285

# /storage/mtr/tmp/logs/mtr-do/oci-mtra85.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/388

# /storage/mtr/tmp/logs/mtr-do/oci-mtra86.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/521

# /storage/mtr/tmp/logs/mtr-do/oci-mtra87.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/285

# /storage/mtr/tmp/logs/mtr-do/oci-mtra88.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sda3" SCRATCH_RTDEV="/dev/sda4" TEST_DEV="/dev/sdb2" SCRATCH_DEV="/dev/sdb3" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/286

# /storage/mtr/tmp/logs/mtr-do/oci-mtra89.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/522

# /storage/mtr/tmp/logs/mtr-do/oci-mtra90.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/521

# /storage/mtr/tmp/logs/mtr-do/oci-mtra91.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/476

# /storage/mtr/tmp/logs/mtr-do/oci-mtra92.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/388

# /storage/mtr/tmp/logs/mtr-do/oci-mtra93.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/285

# /storage/mtr/tmp/logs/mtr-do/oci-mtra94.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/286

# /storage/mtr/tmp/logs/mtr-do/oci-mtra95.txt
TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" MKFS_OPTIONS="-m autofsck=1,uquota,gquota,pquota," SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/522

# /storage/mtr/tmp/logs/mtr-do/oci-mtra96.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/521

# /storage/mtr/tmp/logs/mtr-do/oci-mtra97.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/286

# /storage/mtr/tmp/logs/mtr-do/oci-mtra98.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check xfs/285

# /storage/mtr/tmp/logs/mtr-do/oci-mtra99.txt
USE_EXTERNAL=yes TEST_RTDEV="/dev/sdb3" SCRATCH_RTDEV="/dev/sdb4" TEST_DEV="/dev/sda2" SCRATCH_DEV="/dev/sda3" SOAK_DURATION="6.5d" TEST_DIR=/mnt/t SCRATCH_MNT=/mnt/s ./check generic/522


--77mP7Vjph+AGzl4C--
