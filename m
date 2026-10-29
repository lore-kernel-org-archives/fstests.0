Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276935;
	b=YXF3CCzpBy41SZonjkyPL1CbIZZZqNYFkIUhTTQj97ZzWk6TWmUkbeEJAFF47fE6q7Mh
	 goCEqHICOGPig1S2z7kpXsV1G17rke6PTcPsdPx5DzvMGXXwHAArDLIL7drcZKeq0FFyD
	 n/nzPd1jm74BTHiYreo4yNkrJnyl/zzTkaRkmR2viDjdb9eNECWJLw9TsaW/1yCpfVdv0
	 Rn/pH4oWGGymkBP2KqLz+1FEu1Kw79o2XQF0tXsyd7okqo/CG5qdK2M2+fHE0hEa+HdAq
	 KMPrayqPtDX8UpMRUTSisX5p2AB6MKIn8U3B5qFmGbZRJqrem5QvnikpXux7OOH/hhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OLZk4fMkY6hny3PkLhjA2ZEWzXC1lEsvWoQyKtZD/Zc=;
	b=euyJkNeK9XeZQgZgJaAofKsVRiZ2OHPj0DELzZOZTnKVKTOyOtGQg8BKxxCFfU4dICtH
	 C7i43qRz9Z6Cdfmh2E6/STlJ7fZoHgISz+Lb6EwpSPIp8vRbUJkLf6rirk/KSIqOF7nwp
	 6IpAcDwPqczZUpHyF06XDp5+cnPIYcfBqMy8X5Mk/HS8aI2w9La62rsMXJby95OuSS2Uu
	 WtzqR2LNkHUt429MtXPqC0dzgUydYN9Enx6yAkabXR8K2TCobcVSn+i5rrA8u3niPwuWj
	 ke+oNAU4OWt4jYWLxPrddftS0ELb+mqr54sLY+3wSvtrK9puyqoggJhpXjjQUwwmFNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UXT3wpnm;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ABE606A32A
	for <fstests@vger.kernel.org>; Thu, 29 Oct 2026 12:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91ABE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UXT3wpnm
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso17118675e9.0
        for <fstests@vger.kernel.org>; Thu, 29 Oct 2026 05:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793276934; x=1793881734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OLZk4fMkY6hny3PkLhjA2ZEWzXC1lEsvWoQyKtZD/Zc=;
        b=UXT3wpnmK2bJGtVzXxLx1gl8r/pQ4JCiPpAUHMLDWbqCHfrlYsROoq31SeU/W73AvK
         V+C37gr9fm4EUAHi43kOZazZCcel1Gm7YqNn5tUs7phV0oBBguGqabU7Fo3D97B9laUk
         eSxLqiptmGw0MZL+JRP/lqT1l5ExdLnbxwa3om+IXO0ZiX9/V8BuRZUe5QJkR1w3sgs6
         BhqJ67ODUs6xoO0kIuW5g8BTFo6Ev83p1UN9TX9QXbQf+AQWg+Q0bC5fsYmlVxFM9Nfh
         MrEjqhp43GJTJ3UgPxq6I2t0zvunWRdLGiLbv2EncEFc8sb1LjAh0WS7FKgoXvQtutMt
         xoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793276934; x=1793881734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OLZk4fMkY6hny3PkLhjA2ZEWzXC1lEsvWoQyKtZD/Zc=;
        b=1JZ9NkaUX9sS3OLK+iLoVSeUuqO2gML5F5gP6qfaiG816qL6to2QznF/mpbj265kyg
         szmiUS3LPPXC3ecPaanNFl1T7+1WDuniY2C19wAK16y/riSQbHlDp/xrdZvDmntbXdz5
         wKvLiMwBR32oc2p0VIRBn3r66O6FLEcgNmQkm4BU7j7p9xjVLE3VnwafG5s6ostyRziw
         4xmnMRa65hLHjwowZEfqYNCcaM5HT54a/5CRCF6FKc55oRhMKVLwMsMB3EUizknvM0NY
         PeYGRSbDR90vWhic+ziBAA+5oeD0/RuCNZiQ3Kjoo75NBjYtXVKg2lblRdMCRezv05qM
         3xSw==
X-Gm-Message-State: AFq9FYIJhVPDzFM9hNQ3TSC/MmppgrNmn5ESOuGJgqA5pnYaoLNE/SbB
	wsgHCROh8aWTC4hKY6/xT86ujK67Q+2hKTizzaRdkMrxAop/BH/ot5aKEboKpR8o
X-Gm-Gg: AYBFou1yMIUMXt5Y+aRhBRCqYgfw6dlaYpNRi/pnmylVTYD6nIJDwp05SOVT3fGoNMa
	f+l4vmpWnXsBdNtPHFIOiMQqvQ9rwW/XWgM3T4uKDYMn2HZuCbKEtRRVA09ib3oVNMS79yD++tx
	SY+/oELMuGMmmFLBWuITuBj8US9r7ufuq5mpaV7XutFK2HM25i7P47UWvx5T8E8TrZvTzekiTv5
	ChWSEdauFvMZcc4T7e5h/Mxw0dyEwJ4qZLSDDYTWUn5Rh09wYY3Umi16pDUfJS+R7jyUqY/woKp
	del1vj00sYdOEj4FEXVnnlfJQFtGu5xOJD85csUdfY7jXCbQep+y04KJYhJBC0t087BGYqWKz0x
	Gwiao3rqrV12XmsBKAw9/KbB6VDj6jDal3n1TEkTOCc0wH9qEjCZpov5rHx/S2u1g9xXDFZkGO8
	R36JXJQYDPmh3ShM0fvhwvzjs6LA99EVAgQvfNftqoM2LWv4OaOkU1mNlBEAxz1rW/nsHH3Th8M
	n/HCeQlN0COWgq0ryCoP4cTi6qAx4xkYmstW25t6XET80mJo1pYBkMT1zmLZMok3ZpOA/XrqS9K
	OZtF2UcPVN6PPOybuNkIJaYHsuXb7Y0fVJX+JuZnoFXXNkXTTw8XRXu6l47y
X-Received: by 2002:a05:600c:a10d:b0:4a1:fbd2:f689 with SMTP id 5b1f17b1804b1-4a96639b049mr87370795e9.7.1793276933853;
        Thu, 29 Oct 2026 05:28:53 -0700 (PDT)
Received: from Cluster2.powerhub ([2a0a:ef40:18b5:9e01:225:90ff:fefc:9ffe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f7f50d3sm92477915e9.8.2026.10.29.05.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 05:28:53 -0700 (PDT)
From: Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Google-Original-From: Artem Blagodarenko <ablagodarenko@thelustrecollective.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	adilger.kernel@dilger.ca,
	ablagodarenko@thelustrecollective.com
Subject: [RFC PATCH v5 0/8] ext4: tests for the dirdata feature (encryption+casefold, LUFID)
Date: Thu, 29 Oct 2026 12:28:31 +0000
Message-ID: <20261029122842.230704-1-ablagodarenko@thelustrecollective.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These tests cover the ext4 "dirdata" feature (storing extra metadata
in directory entries beyond the file name), sent separately from the
kernel and e2fsprogs dirdata patch series for reference and review.

The companion series are:
  [PATCH v13 00/11] Data in direntry (dirdata) feature
  [PATCH v3 00/13] e2fsprogs: Add support for dirdata feature

ext4/064 and ext4/065 verify that encryption and case-insensitive
(casefold) directories continue to work both without and with
dirdata enabled. ext4/066 and ext4/067 exercise the LUFID (Locally
Unique File ID) use of dirdata via a new EXT4_IOC_SET_LUFID ioctl,
using a small set_lufid helper utility added in this series.
ext4/068 verifies that LUFID is correctly carried through overwrite
rename and RENAME_EXCHANGE. ext4/069 covers LUFID in inline_data
directories.

Changes in v5:
- Rebased onto fstests for-next (d07dca72 "xfs: test unlinked inode
  list checking and repair with loops"). src/Makefile: set_lufid is
  added to the updated LINUX_TARGETS list (fs-monitor is now a
  conditional target upstream).
- set_lufid: declare build_default_lufid()'s fid argument as
  uint32_t[4] to match the caller; this fixes a -Wstringop-overflow
  warning.
- ext4/069: fixed the patch author, which was a placeholder identity
  in v4.

Changes in v4:
- Added ext4/068: two-part rename test (overwrite rename and
  RENAME_EXCHANGE) that verifies the destination directory slot
  carries the source inode's LUFID after the rename, not the stale
  LUFID of the replaced inode. Tests the fix in ext4_setent() that
  copies the LUFID dirdata payload through rename.
- Added ext4/069: inline_data directory regression test. Verifies
  that a LUFID set via EXT4_IOC_SET_LUFID on an entry in an
  inline_data directory survives to disk. Catches the bug where
  ext4_add_dirent_to_inline() was passing NULL instead of dfid,
  silently losing the LUFID.
- Expanded _dump_dir_structure() in common/ext4 to match directory
  entries by inode number instead of filename when the directory is
  encrypted (ciphertext names on disk do not match the plaintext
  filenames visible through the VFS).
- Minor updates to ext4/065 to use the improved helper and add
  verification of the fid= field in the encrypted+dirdata case.

Artem Blagodarenko (8):
  ext4: add common helper to check whether dirdata is applied
  ext4/064 encryption + casefold feature combination WITHOUT dirdata
  ext4/065 encryption + casefold + dirdata feature combination
  ext4: add set_lufid utility
  ext4/066: verify LUFID dirdata operations
  ext4/067: LUFID and encryption+casefold+dirdata
  ext4/068: test LUFID is carried through overwrite rename and
    RENAME_EXCHANGE
  ext4/069: test LUFID in inline_data directory entries

 common/config      |   1 +
 common/ext4        |  63 ++++++++++++
 src/Makefile       |   2 +-
 src/set_lufid.c    | 196 +++++++++++++++++++++++++++++++++++
 tests/ext4/064     | 153 +++++++++++++++++++++++++++
 tests/ext4/064.out |  17 +++
 tests/ext4/065     | 252 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/065.out |  26 +++++
 tests/ext4/066     | 159 ++++++++++++++++++++++++++++
 tests/ext4/066.out |   4 +
 tests/ext4/067     | 137 ++++++++++++++++++++++++
 tests/ext4/067.out |   4 +
 tests/ext4/068     | 202 ++++++++++++++++++++++++++++++++++++
 tests/ext4/068.out |   5 +
 tests/ext4/069     | 164 +++++++++++++++++++++++++++++
 tests/ext4/069.out |   7 ++
 16 files changed, 1391 insertions(+), 1 deletion(-)
 create mode 100644 src/set_lufid.c
 create mode 100755 tests/ext4/064
 create mode 100644 tests/ext4/064.out
 create mode 100755 tests/ext4/065
 create mode 100644 tests/ext4/065.out
 create mode 100755 tests/ext4/066
 create mode 100644 tests/ext4/066.out
 create mode 100755 tests/ext4/067
 create mode 100644 tests/ext4/067.out
 create mode 100755 tests/ext4/068
 create mode 100644 tests/ext4/068.out
 create mode 100755 tests/ext4/069
 create mode 100644 tests/ext4/069.out


base-commit: d07dca72d2455f4ba8c660ad4c008541ccccb707
-- 
2.52.0

