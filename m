Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08BF3164BB
	for <fstests@vger.kernel.org>; Thu, 22 Jan 2026 07:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769066795; cv=none; b=AWqFPlbjcvhSVAvfDx0E46M9rs7Q2ah5V7KgfBe90+whpYymi1IQBeajS9GZabLkCcU8MUu7zr8zibHVauHK27mJOo6j8n6+9q+86v23oB7fdzugNeY0A6K7BHSsZIaSnCowXZfEHp8t2g7XiNrI8WXQ32zK3ZzarVh5qo99I90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769066795; c=relaxed/simple;
	bh=GkuyJHzow4uaWXqTwCaSnkBAYNMG7BavCVFAbMybR8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SrJK34NJrdoebhR/Zf3gWTEp49qHBRxTQJ2BkLa754Z7gmskIvRU3aNq91+LtHC6agzRDEJtOMS7Wxtk8cKohw93ga6yC6KeFf0XOmRqZfsqbfpgoJCDMDXNxS4Ckq7oeiFupOKtKynzlwqjk9OGW2Ig7bHiwwbECXN6p/UfHGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IJ5zuUD/; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="IJ5zuUD/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1769066753;
	bh=CmPWv0dSNUwA98WPGS0iC+mppELG1ojdkBdr8eQ6jto=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=IJ5zuUD/XpbasudZULgwV6sqoxCWohbfHsIUKM7b8M0M5Ts11iRG4iIxCZK2ys97a
	 Il9TaCQkt4l7AqcNvyLFIZvXb8gWdb8Bp7y+P7UUxfrlVySYskKlE51cfinNxVECVc
	 oQXIu20+7G4nal+OSLNXyIQ0cTWgXwYmEDy9w+Os=
X-QQ-mid: zesmtpip3t1769066740t21f59e29
X-QQ-Originating-IP: 2yWIRiv/ztq975SzZzaupfYJfpSUhjCuHeWsbnDS39g=
Received: from hongao-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 22 Jan 2026 15:25:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16766284751094823132
EX-QQ-RecipientCnt: 3
From: hongao <hongao@uniontech.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org,
	hongao <hongao@uniontech.com>
Subject: [PATCH] common/dmflakey: resume the correct flakey device in cleanup
Date: Thu, 22 Jan 2026 15:25:33 +0800
Message-ID: <8D60A094754F59E6+20260122072533.1059397-1-hongao@uniontech.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MyIXMys/8kCt46qbck6vm7qorw3SMPYCOTTsIszYQCFdT9Gq3kXQr9YF
	QwnjIms70+BMzu45Wfv2v5dm6wx4ys8SeZSWSv5D/lqr7SkJRifqC3yPYW3aXYBa2cHiRYw
	f7Y9Pj7onf+6+AiUWr0bmsPT0HRfHe2UXPQcldMtbPlSldM7TXuMLEkT9P1+RYqreWZgSld
	uIidzDryWkvS1aVlO6MCyaMuX4j8q3S6zNzysi+F0j8VCyNrIhNvcj5Fj0Y7AU8usjpGSMF
	dxcWZup3kCPiQhDQQpSEiWZJEh5JRCXMc/L6mkeZsIAgmB51fo98gZHS7QpRR+n2BY3pDGo
	e34U2mQ4bFoFki/teBompKtj5WxUnzb9rscpFTlooBHL4TxsBYmLqVV/18nqi6QdGQlODcj
	dFxHzqHvpFrvPetoWGNXmMGJSOgJ3eWt9FHmwQqyVV4g8AHlr43kn4lr5LnrZGfSldInAW/
	U0W1SyizJBPo9fwTW/x9LX0UwhV8RHhhfFFYMERj4e2qsU/js3ZXPpNE/cPkpa0fVjCuPJH
	Aos68uQlkipzEYsXPHrLRP0D5CTURxJ0AllrJQMEUJzBMCybjQALYMtzz5dyQVij51V+Yre
	33WopCYd7ZVlGljz2L8zwmLUGIGcBpgnBn09NVrPfi9JUwGbXn2jSkxOIs1SPsAfWttTT7s
	GAXbafmioJNn3IeQaWgrk+aK395XTf72/AV/xn9gvbCM9bBgY3U9Wi15Jd4LR3Bl9kljoiz
	dAf0/+TlpmG9AzHU+sWrUqJv0vc7W5rkA5ATPl/DBNDwqEWFJXx0uxOFXMM49748IPQxPHk
	LRSou9OBNhd4E5Jx6ijzdJS1x7YABjBmmSPZQSiD4OjMFdmhVAqRIzQSBOdXlEz3TLaHZbu
	TFFhIUdXV8Nn0oWZlSRKKyERFgQAhB5JZ9MFGt1oky9azgLcPEehxpF6dgHR+Jku5CEE41z
	HbMivcNRoIirU4TaMb/QiptkgNgxSlHbdZOT35pTQXPiuhMM48+wY+Rk/csXNs5U+mGRkpZ
	tEXVyjVFLEEUtwLCRhfwROS5tlfUcFqDQqP9LK1w==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

_cleanup_flakey() tried to run dmsetup resume flakey-test, but the device
name created by this helper is flakey-test.$seq (e.g. flakey-test.034).

If a dm table load fails and leaves the device suspended, resuming the wrong
name means the device can remain suspended and subsequent unmount/cleanup can
hang.

Fix this by resuming $FLAKEY_NAME

Signed-off-by: hongao <hongao@uniontech.com>

diff --git a/common/dmflakey b/common/dmflakey
index 7368a3e5..b07e64a7 100644
--- a/common/dmflakey
+++ b/common/dmflakey
@@ -80,7 +80,7 @@ _cleanup_flakey()
 	# otherwise the umount will hang
 	test -n "$NON_FLAKEY_LOGDEV" && $DMSETUP_PROG resume $FLAKEY_LOGNAME &> /dev/null
 	test -n "$NON_FLAKEY_RTDEV" && $DMSETUP_PROG resume $FLAKEY_RTNAME &> /dev/null
-	$DMSETUP_PROG resume flakey-test > /dev/null 2>&1
+	$DMSETUP_PROG resume $FLAKEY_NAME > /dev/null 2>&1
 
 	_unmount $SCRATCH_MNT > /dev/null 2>&1
 
-- 
2.51.0

