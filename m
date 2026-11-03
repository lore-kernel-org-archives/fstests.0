Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713877;
	b=XXPLM9SMOWk3AdiNKFq+uumvmEtyMGRY9G838w/0ybZw6uOJxbjQAbxOWdh2vNCbxeaf
	 Vt05v9Dm+oEjqes8SCKY5Hx3gIHZ6zTAqVxMjJHsm6rNAQDeRpYW/aWFyXgItR28D7PjZ
	 uxwCQsCF1B1/dvb8Vp/pRsnJq4sKfIdeOBAOVPe43Lqn9y04KS/NuMys3Dz5za1VY4zUC
	 OS0AG3lPk8Xu4Epj41MZinuE0ee3qztDzX6EC5CfLKE3xHtpDKzKPLU9EvWMJIokO2644
	 h6LKa38XC8xmw7TlScBezNFwDUJ2xhsEyHw1X/NVxT/cYteVd/bwy8K3UmwiPYC/m+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mBJlz7yMX0N/7af4hSUS50hoXHbP9fZz8A/BckYYgew=;
	b=HXDiCpHbdOZVDgxbBszXK6UtLz1Tj9c5nBMRk+skaay6+IEfEX48uvCpdM6Z1xxYKGC7
	 Cq7UXXyqkHMXDetU2Z3JHvFbNmDh9mWMlTHWMU7MmR/JtT3oeA3r2978m8o7MWJtFlC9G
	 t62DEsqQ4w3OGrXllN3MUPZoakIB3E/+dXnVcHhm4jhRtpTaVcnou7IUGERqjibcVs2TP
	 P89CH53at2v+9/TLq8BUOF+G6WljS+9tL6j6NTatr7DNuj/r+IlVb9aJqPAmDBVUgUR0u
	 15gz9A54YUHht2p/8oTzO0OGUp4egZ9VDQSFhpy8b8vG9hw1aV0p7tCzV7Wc+864oXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jc35+wFp;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E4606D830
	for <fstests@vger.kernel.org>; Tue,  3 Nov 2026 13:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 001E4606D830
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jc35+wFp
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so4523585e9.1
        for <fstests@vger.kernel.org>; Tue, 03 Nov 2026 05:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793713875; x=1794318675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mBJlz7yMX0N/7af4hSUS50hoXHbP9fZz8A/BckYYgew=;
        b=Jc35+wFpLDWcuZJHtOzePccoeMO3a4G39hb/c06rDgnBbioizCaQLO3So6/tmcGpGa
         Y8jTyTmVM7wZdqM9tfjvw5NoFwG9ZSsXgfB5Mz2S4FEShRXLmY3ul0lMtwb/nDGxYpmW
         WKFX+j/VQNY6/UpfW2XSVhejSpNgnfAcksT3LgrtreaTbV70yC6hCI4H39k+/dxN+ULq
         zMlelnTNsC1ExNUL+S/Uranap6xveQ6zTrCb/5FX8tSgP9cheXYvYcb4SaVX7x5IVrbs
         Ljg/J2GtoE/JgCTPnQRln5Kw2zsI+1B3DOgL+fT2CWYcMz9z/0kFvOKrXyOVWfmvUi7L
         P3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793713875; x=1794318675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mBJlz7yMX0N/7af4hSUS50hoXHbP9fZz8A/BckYYgew=;
        b=x8Dy62QMezTjl3AvH2abBr152rYSA5xqGFQq9BuJsW97Nx0fwZNvybFzjVq9o8StK0
         mNboFT5VG9o3k428EYmcgDpDQDifXgh9koB0pwDH3VeZsRks2OTLE5/nKCNQ4ouqiMDe
         2t4apVfSeY0X0pCAtW4U7JrlBtOyhjMmC8Le4kDLi3PnZMl65Zdl9KeMhiItI5TVGTVR
         UxVxhwl20VlL75dLkqxutgCAEtDcZhgY/EtaiS6msFUPooQWbz2CLos9OG+2eDcYPh/c
         xLQqklCVl8gFdXPW5xcxXcgRCJXTq93de12DylAMKBlCg7+UJm4skuoiuw0Pr/Jlq+48
         oDKg==
X-Gm-Message-State: APuU4Z+Z6czAnK/Yll5c1Ovzs2qg1E9hqxaanm8Ar/XGfhuY7H/KfYzI
	2vNL611f+aB5H5zoVzcpcobkoTvr8bRmKX0FqfC7unw1QxS+Z57AwDcMLK5ZdS2j8KE=
X-Gm-Gg: AYBFou2OaaKDozC7M4DkIR9y8Bp+JefXFTRndqKM7xm5Y5/9AQws6CRMmWpT8XWao47
	huEGju/b1MgP2Fg4lKR1fJPmHYh3GOH2LMlz/QQkkjW8Ef6rEheu2ry0/h3y5kT3Js4fPxuHuOf
	Kes+rrsHRbUwGPbKyPc7UF7jbhIeOQl7f+/FGwq5EJ5df5UVGLYMGu/Xm2EkibE8cOaLnPmViM0
	MeEeFTFsiZVJuunFjr2qS1qDDDIWbu3JmSM5LpUiGKDAtUv6YE5nP/8aQN/+t0bQLlGv21yD+bo
	QY+PDIgjctmB1h3zgLNu+iOspJxPHJT37jf7MFfSLP3Ystq2jj+3Qw7y8VHZLYGoOszy0tI9GVF
	/b9CfRtSW1gwshzn/EvLz2zJE0PZKLBT0e1R68JMKb7aucO4sdH1HiihCFAf5eNT5jKVrznU4vV
	dgW98jQlw7RFvcr76sv0JAXuXK+8fR34zSUwJe6NEexXR9j36768ylODp1oKPj61lENe0NPMo9m
	Bpi4u0vgPQmpb05x7GLJwpMEuF5P9XNMT+oN7x9yl48YK7WI+2abHWovY4bCzLnMxBobQ14aJzr
	qYSu0l6EACYXKvhWY7ZdBoHPqdQqEnZi/wMy981WUGqMSs6czGXWkcYyOxyL
X-Received: by 2002:a05:600c:4687:b0:4a2:10f9:37db with SMTP id 5b1f17b1804b1-4ac16fa4dadmr297818665e9.7.1793713875405;
        Tue, 03 Nov 2026 05:51:15 -0800 (PST)
Received: from Cluster2.powerhub ([2a0a:ef40:18b5:9e01:225:90ff:fefc:9ffe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a96fc87fsm55320335e9.12.2026.11.03.05.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:51:14 -0800 (PST)
From: Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Google-Original-From: Artem Blagodarenko <ablagodarenko@thelustrecollective.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	adilger.kernel@dilger.ca,
	ablagodarenko@thelustrecollective.com
Subject: [RFC PATCH v6 0/8] ext4: tests for the dirdata feature (encryption+casefold, LUFID)
Date: Tue,  3 Nov 2026 13:50:56 +0000
Message-ID: <20261103135106.610169-1-ablagodarenko@thelustrecollective.com>
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
  [PATCH v14 00/12] Data in direntry (dirdata) feature
  [PATCH v4 00/13] e2fsprogs: Add support for dirdata feature

ext4/064 and ext4/065 verify that encryption and case-insensitive
(casefold) directories continue to work both without and with
dirdata enabled. ext4/066 and ext4/067 exercise the LUFID (Locally
Unique File ID) use of dirdata via a new EXT4_IOC_SET_LUFID ioctl,
using a small set_lufid helper utility added in this series.
ext4/068 verifies that LUFID is correctly carried through overwrite
rename and RENAME_EXCHANGE. ext4/069 covers LUFID in inline_data
directories.

Changes in v6:
- ext4/067, ext4/068: run set_lufid through $SET_LUFID_PROG, as
  ext4/066 and ext4/069 do.  They used the bare name, so they only
  passed when set_lufid happened to be in $PATH.
- The kernel series (v14) now limits the EXT4_IOC_SET_LUFID payload to
  48 bytes.  The tests already use 48-byte payloads and are unchanged.

v5: https://lore.kernel.org/fstests/20261029122842.230704-1-ablagodarenko@thelustrecollective.com/

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

