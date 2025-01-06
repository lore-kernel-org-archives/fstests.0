Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C037D1DE89A
	for <fstests@vger.kernel.org>; Mon,  6 Jan 2025 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736172090; cv=none; b=aoLyRzxgERUzLgMITdVgDnqrGxOBd4c8tZG955qhcOR2NcoB2nwSQPy1ZGsGHuGxZTuKd3QO6gpDzZBe/nz/838wliKUsE8giCUMFW2pEVYzBYDqVsPDcOcFWXMzbpdc1lsjSIKpHpFeHy+FnUua8QEyhUI6Jt7501r8JBTpMEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736172090; c=relaxed/simple;
	bh=ZZburt9AJEajz5k7XXnIEvai3PBklSgMjuz9a5Mf0cI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OEiiUgz/m3SecoT+OdYqHedaUukafjiKPZ6QT1w/KHHb6VMYwoSbgAdqXKiUi+Q+AYp+Y+9eDOm35kdFJx5q/5Q6Pb5BPQlvvHaDRNitb21NMdQ/KjjWcNaXY4zdptxNI5rpFGJwyR7eI8jElsCcTqTLyZtJlTHD49Beoez3x3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Pyht45Ea; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Pyht45Ea"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385eed29d17so6812509f8f.0
        for <fstests@vger.kernel.org>; Mon, 06 Jan 2025 06:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736172085; x=1736776885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LWSGs2y6f9x6GdFKyNtGUXQtCcC0x80vP1gQ2rVmqNU=;
        b=Pyht45Eaqs6T9kAcO27w3wBoUeSlRpem+H8FcNx57+lA7IT0R1xehPihnJwDWE+HmE
         iHMuNzkvfxo++ahRlnVf+bsYPHa4OFIoCO9iBbho462HAhTHtZWOGn+GE2Pdwt8CPprj
         yjJAgSVyAFBMYT6C2Eqp84KEFODaN2t34S4m3EnW8A5dxnWN0rZvqhFC8gmW8GwGWLYV
         YOQuelqbW9K/N0Kdu0QMXjWfW6EeI94NZuntOXS708jJ5co65EnebpLrtj0oRGofrrYy
         IQVTTMOL4yllM8v4gvoNB+uRlqi7Rhd18eJF7T4oy2OhoDyHALdpXA2UmaIutsx6c8LB
         eU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736172085; x=1736776885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWSGs2y6f9x6GdFKyNtGUXQtCcC0x80vP1gQ2rVmqNU=;
        b=QCSJR/7dRABldlamZXzYP3mYu2Yr+m5pxR+En/D0Y9VDbqGy8cHJ7w0ntKIek+3edE
         76b0pmkR4BC4pnZJZTVVcRWmiXxqghdV/KQCNlu5Tgh5RYvU3PUjUT6Yiu/Qc2wpxPED
         bvgBAbYQZyZq7V7GMOgmEKMIT/edL/fnngJpH84XCrNdDCkddaQFUa3khNxp6GEhk0n5
         OBSV3fS7+W14XeByfmxMZAUOkDOrbxf+BE71bxOsgVG+eTVXytnSTl9ZFJnjOUcGCEiJ
         37vAhoaHn+g6rAZr0OWznrK+PQJpZi37xZwAw4cUk1929DGYRVW9ohb7d0VmJEpy1umh
         J05Q==
X-Gm-Message-State: AOJu0Yxu9Pafz4B9izhHAdMJLR7c9lhqcYor4sXlXG5yqDG9dDNAB+x1
	R+9nKI1XAtJjlUftRx2E6WRnPMCUfqzBQ/5hePTiYiSnTc+mGFqqtnlD+4SU5yNrEkp5coFgNjN
	vzkk=
X-Gm-Gg: ASbGncseFpF3OVVk/Ugy6X0GvwTwKNIqGiYazfQ4iC6nZTGu/t9qp37ni9Hnvl9d2yI
	9qXjVFcXsVippx/TkT2Lj9VP6rpxCUDLFV7hZs9o+vu3O4CAsH8eE4yrbxwIp0+GR1p8klLjvo+
	CaZ0MaEIw/bHhvgcPYCAwTWpfiiCWfLC1PcriChdYrglLjLmawKdWGyAiERvW+Rq2I83ahbfwqv
	qUTYXGSdHeAnuD9yvOoxOFrxfWgEQsEnxZkvq++F7Zx66XLipJzDM0E
X-Google-Smtp-Source: AGHT+IE9TRIUNkcxWhGiBmroxbENquL0ntE/RsJlK1w3HEJC8ySJH6EbR0D6336E1VwiHJq2HY4EZQ==
X-Received: by 2002:a05:6000:1a8a:b0:385:e429:e591 with SMTP id ffacd0b85a97d-38a221f1c81mr42553374f8f.23.1736172084387;
        Mon, 06 Jan 2025 06:01:24 -0800 (PST)
Received: from MacBookPro.lan ([23.247.139.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bc4b7sm1511188585a.12.2025.01.06.06.01.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jan 2025 06:01:23 -0800 (PST)
From: Su Yue <glass.su@suse.com>
To: fstests@vger.kernel.org
Cc: ocfs2-devel@lists.linux.dev,
	Su Yue <glass.su@suse.com>
Subject: [PATCH] common/rc: add ocfs2 supported timesptamp range
Date: Mon,  6 Jan 2025 22:01:18 +0800
Message-Id: <20250106140118.91905-1-glass.su@suse.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ocfs2 supports timestamp ranging from s64min to s64max.
Add it to _filesystem_timestamp_range then generic/402 runs.

Signed-off-by: Su Yue <glass.su@suse.com>
---
 common/rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/rc b/common/rc
index 7b5bc0b45047..3a38a7ad6196 100644
--- a/common/rc
+++ b/common/rc
@@ -2690,6 +2690,9 @@ _filesystem_timestamp_range()
 			echo "-1 -1"
 		fi
 		;;
+	ocfs2)
+		echo "$s64min $s64max"
+		;;
 	*)
 		echo "-1 -1"
 		;;
-- 
2.47.1

