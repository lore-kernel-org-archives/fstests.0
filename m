Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029722773D9
	for <fstests@vger.kernel.org>; Fri,  3 Oct 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759484120; cv=none; b=TXUBRkpKQeBtzsljNCQk23sAxuIrA98SWuGr3G183fLPFzBqBfvxx1prMprTSnb32AOBXBwlc96/afw/3x1OxOfUYiMUZOryDryIghUTc3HJ/tGW+OJBp76+mgyRjcT4L+UjXKtPcFsjcZpcKZXlDhvXxhA/gIdMKnGRk3OnfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759484120; c=relaxed/simple;
	bh=vvUJddjEBDF+Ztgm1hAHoT+ASJXHJAAKJ82WwfFRfu4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EZKwSwhDk/oi/s7FRNpjjw9Thw6chSLrYMx+LoSh7QP09ioQnc0yGLdQ0eMnUa/fTNa+3ox3EC1jbJW31PJWDQA8XyACDlvvRyhZtwI/V0GvvgKmtCX2AFqy80vzU9HwIZEGwTcpE1TP7b0sVSK9aIkdLPeEsng2ZC73ZlfA+2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0vUazgr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0vUazgr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759484118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cTvI1DpoQ3LONUfIqcabKF8qqakEhbOmxQY1Lj6nxQQ=;
	b=A0vUazgrwZv7oje99iWiIXl7VSxlBzAXfsbsJu/DaVz+zo/g9hU6aAJlwJ9DMAP3laAdVU
	+AYPR6AWjeJU2p84xtKmfejlufIhX9g6LqMuPai/CTxP3He5A/bHiLQIaSUgBn5+yLOPNA
	pyWwAfQr1nhF5f8Y7H5RK0HIkrydAAc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-XGXP3iY-PgKTKsti6gPnCA-1; Fri, 03 Oct 2025 05:35:16 -0400
X-MC-Unique: XGXP3iY-PgKTKsti6gPnCA-1
X-Mimecast-MFC-AGG-ID: XGXP3iY-PgKTKsti6gPnCA_1759484115
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee10a24246so1182112f8f.3
        for <fstests@vger.kernel.org>; Fri, 03 Oct 2025 02:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759484115; x=1760088915;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTvI1DpoQ3LONUfIqcabKF8qqakEhbOmxQY1Lj6nxQQ=;
        b=CTTv8ECqchUST6QtdHUYbrbeP+fnQSAB7+ZWXINBHGXdWUEKt82dfVEUNmU4aLHnTS
         djnjD+S2Nb9hX1jByH/eV8Rozl5gokFPWS1FLQYHDjf+d2L+EqsC1i0DgBCvDrshNSyp
         IPa4ybannSrCTwBnqA115kaIx1Xw8FStR9HtR3DvKg4UbXq9S4/lvqieel4N4IKQ8KlD
         HZjoqafSd5duJFK8Jn2BdOiInJE8qFb3MA3SeFY4yY+C3cVfhhjWD6/33PafSBerU/Ki
         m9GYKF7Ez4Zf512+BQp9ItpqBquUXhWUfRbpMCtP14vIqx26eIwG/Oqai2swiiuyv3RS
         pMEg==
X-Gm-Message-State: AOJu0YxEAqZoNnomozDshycTl34JgWwPHMz/FYRIxu7ceAcec3RJX0BG
	Gri2T/KyIrOh2GkH1foQpwamMLVhHWSB0fgPxlP5VhG66uln0SZPpv3TOuzGr3b8tTLGwUpY1v4
	q1m9bMqTOAkPziqyUXNzXbVhR35vs3TVgng3dpowjxFFeBnE4Y7I+HMdCXA==
X-Gm-Gg: ASbGnctAT2vyDE0g/iqBYvM/mrrhHlvcB69OCJ5QppV/Vi7Z95+tzDwxU2t84C1Lz6T
	NHpzSbe0zIGeX/cr5I/EaTJesFokudMiMRm48YmFF8o4YVcksChqNs4TEa1p/M8kGUI4uYSod9S
	Y/f7BZ0803pXUUZX9I9X18X7ICV5WzWPmlOlcF6VP+XRMoMcf8VXbWK8isQ+ftghlY4T4vjW/5v
	MHPug2cXCphU1SPWuLOaxZrk56AAr8gqRY8E+eZXT0ZhY35K1RAPW+46++rts2zTMvNesfl2IvB
	MVLQxBi05JbWKBJ5RryLKIL/pTGWjiAYHbpOayiez1k7j9ET1B4hnBVDr2nf7cgDIAfaB6y5
X-Received: by 2002:a05:6000:288d:b0:3d1:6d7a:ab24 with SMTP id ffacd0b85a97d-4256714bdb4mr1271045f8f.17.1759484115150;
        Fri, 03 Oct 2025 02:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0vyuKNoB3TDCcPMspLmidueip+wl7tYR26n0nTXJo0IDYg1kMeuPVLq6KLG4A5ZpZfhojIQ==
X-Received: by 2002:a05:6000:288d:b0:3d1:6d7a:ab24 with SMTP id ffacd0b85a97d-4256714bdb4mr1271019f8f.17.1759484114612;
        Fri, 03 Oct 2025 02:35:14 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a020a3sm121695005e9.10.2025.10.03.02.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:35:14 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH v4 0/3] Test file_getattr and file_setattr syscalls
Date: Fri, 03 Oct 2025 11:32:43 +0200
Message-Id: <20251003-xattrat-syscall-v4-0-1cfe6411c05f@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADuY32gC/2XNQQ6DIBCF4auYWZcGBBW66j2aLqgOSmrUACEa4
 92LdtE0Lv+XzDcreHQWPdyyFRxG6+04pBCXDOpODy0S26SGnOYF5awisw7B6UD84mvd9wRRmgL
 zpkQmIV1NDo2dD/HxTN1ZH0a3HA8i29evJak8WZERSkpNVS0Mrwyj9ze6Afvr6FrYsch/gKLqD
 PAEqJcWkjMhKqn+gG3bPkXgEBTwAAAA
X-Change-ID: 20250317-xattrat-syscall-ee8f5e2d6e18
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, 
 Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2156; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=vvUJddjEBDF+Ztgm1hAHoT+ASJXHJAAKJ82WwfFRfu4=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMu7PuFiVNFlSp31Tg6o8o7oE+xkXo3cWqYzM4rwvJ
 r5oMnGuPNtRysIgxsUgK6bIsk5aa2pSkVT+EYMaeZg5rEwgQxi4OAVgIvlZDH/Fc21s+h4uW6L8
 7YJoZOVl85LTIiecjiqefrIiOF5n1e0PDP+jb4nm3n+99ttT1gXWRzP5Xn/9eN/o2Yw0y1/beWa
 UVC/iAAA710mh
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Add a test to check basic functionallity of file_getattr() and
file_setattr() syscalls. These syscalls are used to get/set filesystem
inode attributes (think of FS_IOC_SETFSXATTR ioctl()). The difference
from ioctl() is that these syscalls use *at() semantics and can be
called on any file without opening it, including special ones.

For XFS, with the use of these syscalls, xfs_quota now can
manipulate quota on special files such as sockets. Add a test to
check that special files are counted, which wasn't true before.

To: fstests@vger.kernel.org
Cc: zlang@redhat.com
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
Changes in v4:
- Use _filter_file_attributes to focus only on nodump in generic/2000
- Add _filter_file_attributes to common/filter
- Link to v3: https://lore.kernel.org/r/20250909-xattrat-syscall-v3-0-9ba483144789@kernel.org

Changes in v3:
- Fix tab vs spaces indents
- Update year in SPDX header
- Rename AC_HAVE_FILE_ATTR to AC_HAVE_FILE_GETATTR

Changes in v2:
- Improve help message for file_attr
- Refactor file_attr.c
- Drop _wants_*_commit
- Link to v1: https://lore.kernel.org/r/20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org

---
Andrey Albershteyn (3):
      file_attr: introduce program to set/get fsxattr
      generic: introduce test to test file_getattr/file_setattr syscalls
      xfs: test quota's project ID on special files

 .gitignore             |   1 +
 common/filter          |  15 +++
 configure.ac           |   1 +
 include/builddefs.in   |   1 +
 m4/package_libcdev.m4  |  16 +++
 src/Makefile           |   5 +
 src/file_attr.c        | 274 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/2000     | 109 ++++++++++++++++++++
 tests/generic/2000.out |  37 +++++++
 tests/xfs/2000         |  73 +++++++++++++
 tests/xfs/2000.out     |  15 +++
 11 files changed, 547 insertions(+)
---
base-commit: 3d57f543ae0c149eb460574dcfb8d688aeadbfff
change-id: 20250317-xattrat-syscall-ee8f5e2d6e18

Best regards,
--  
Andrey Albershteyn <aalbersh@kernel.org>

