Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD1B1A2381
	for <fstests@vger.kernel.org>; Tue,  3 Jun 2025 04:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748923829; cv=none; b=qQp6Duqh9MEbUZgQdIaZEQn0seRrWjTlcE1fzc565Lspyq1WwPPCCRRXAPfPIieMGHX4FtSGQwMYqkTTnQblvHM9+0TY1jYBdKKZjGbq21TudhU69qgRbhIT43Lw9NItctP5yHdAuHVdEfldkeSdLMYW/KMxHGOGalbbyHilrRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748923829; c=relaxed/simple;
	bh=mWKW1BZiWQdg5ZGyvvansCbXzzKjs6P+f7nmIjIRSFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f/lQPKrcH+It6+aaFGMim8wraSjy/ZM0GPY3nn78/h/K7Su4rHVcxzFsNiGE/eEpjgcrmyssx5EuBsDw4loZoZcgQCWoaIOJnvmP1kn/UeK/U/0tE9Tu+XanvV5laC37WYHFv1O1vAplDLRUMZDlJThAJGcgEVSSevrTCGGrPwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Er3cHrxQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Er3cHrxQ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so4089997f8f.2
        for <fstests@vger.kernel.org>; Mon, 02 Jun 2025 21:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748923825; x=1749528625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vsip5heoQfOlVVanshNnzNCVpVKbPMgYCx8wxtCCQPY=;
        b=Er3cHrxQLFmP0IgZCQ00xoI7uXmAloMQ4Nj/cwUafwK3K0TtgO1SpeM/Dfr58O52sg
         2v7HKzESWsFcukCE8nN1GuV8hiHCtCgw2AVzGSRAIpRNJ0kES5znfv0L+xlN3fDFDTWJ
         Q5T7mUaFgg/ivWVvUafXyXZpA+xg0wE3/EUBPMzLQSqO6oUIIc9N8f9pbeois2qdL8en
         8cSmqG08At2OUHHJpWr9yrIwlUu4E+thi8YlE0hh7qRm2BiMyjrSi2bisqgOsztCgOvb
         BQ11Ypg1ShoKWq3MA001cAGRqoPAQfViq22aqlPOmG03/FJsyA+nCipwlY0lqEzMvYF5
         aotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748923825; x=1749528625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vsip5heoQfOlVVanshNnzNCVpVKbPMgYCx8wxtCCQPY=;
        b=VsweiJe7Aq6e0FF2cYYqifd31oCGneXbymXvMEZW0oDDoU4EvLQy1vFNZ21XuYSTsj
         /XMQu97qgE8xVI83lZbDHCl5DN2I6tZoVDM6XbJhogaz2fVN6hBunwX0fIq27F6Mwz9/
         bZpq0bGT391AB2B+Lv0tcnj/eoaaf54XmO3Ql0fe3NYTxoPKjRLhhp2VAFOI3QLWg8pl
         BQCRpVtxsg81kGy5CoW502nIxOaJRRI5GK6zcWLDFUnDHz6dbePucYkGtmjnztNJNCrL
         AMHVwGy5TWw1ZV16fqIh0AdzuPxFzVDTLurazv1odZTSVHiJWqxDv4OFV5KuPnzxtUgL
         G+0Q==
X-Gm-Message-State: AOJu0YxZT1mDSebjB7cSfFeMAyx6aAHl/AfOkN8zDHjVrnj7CgvY+az8
	xASnuV8bVj4xhd2EiVk7McoI7X28ju/eYMb1ROFCkHwGG8jsQ+xW8SmPYq6sGG0tXgBpoHx31yP
	5Ek9YsV6kzB92
X-Gm-Gg: ASbGnctJ1/h/60sKEFp3q8R8UXUFJcgI/ipz5yvPDfyXUIbCsA3aMTr9xLhJK7mCNNh
	p4CmkiwWbZJzuGqG6sDPNEjf1bIyX+TZlQXAp+M2/XijRLbmuqtuNicC9U5tw//uJY5o4rPGEkG
	wcnrzIlHxmpetsOvFosH2ng0hE/D2jXHE04hRYN9G7AvLPq+t1+Lewu01Puky2LOhsMBH50WCWU
	3MBh7D0OjcyCi9POZpd5R9U93bbPEXqAcG12AWf4YhuwyWxzae4EJyoaRn+OJHBDIFiVqbeysH6
	rXoW1KHorPsxaLbzCFjHPClKvxPqBXJ1fbchw/noDRnbWMtP7cw=
X-Google-Smtp-Source: AGHT+IHXiNSm1xbktSoVTeEFqtz86yosyFGRGmS6MYGmA+3pl9em5SkbVzFGQnlHyudvGkSUlboU4g==
X-Received: by 2002:a05:6000:1a85:b0:3a4:d367:c591 with SMTP id ffacd0b85a97d-3a4fe154d16mr8982375f8f.10.1748923824709;
        Mon, 02 Jun 2025 21:10:24 -0700 (PDT)
Received: from MacBookPro.lan ([5.255.111.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf47c0sm78297245ad.175.2025.06.02.21.10.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Jun 2025 21:10:23 -0700 (PDT)
From: Su Yue <glass.su@suse.com>
To: fstests@vger.kernel.org
Cc: l@damenly.org,
	gfs2@lists.linux.dev,
	Su Yue <glass.su@suse.com>
Subject: [PATCH] common/quota: adjust _qmount_option for gfs2
Date: Tue,  3 Jun 2025 12:10:09 +0800
Message-Id: <20250603041009.59811-1-glass.su@suse.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gfs2 supports mount options 'quota=[off/account/quiet/on]' but
'usrquota' and 'grpquota' are unsupported.
So in _qmount_option, transform $OPTS to 'quota=on' first.

Signed-off-by: Su Yue <glass.su@suse.com>
---
 common/quota | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/quota b/common/quota
index a51386b1dd24..4b8052e07dde 100644
--- a/common/quota
+++ b/common/quota
@@ -283,6 +283,12 @@ _qmount_option()
 {
 	OPTS=$1
 
+	if [[ "$FSTYP" == gfs2 ]]; then
+		OPTS=`echo $OPTS \
+		| sed   -e 's/usrquota/quota=on/g' \
+			-e 's/grpquota/quota=on/g'`
+	fi
+
 	# Replace any user defined quota options
 	# with the quota option that we want.
 	# Simplest to do this rather than delete existing ones first because
@@ -300,6 +306,7 @@ _qmount_option()
 		-e 's/\bpquota/QUOTA/g'    \
 		-e 's/prjquota/QUOTA/g'    \
 		-e 's/noquota/QUOTA/g'     \
+		-e 's/quota=[^, ]*/QUOTA/g' \
 		-e 's/quota/QUOTA/g'       \
 		-e 's/uqnoenforce/QUOTA/g' \
 		-e 's/gqnoenforce/QUOTA/g' \
-- 
2.48.1

