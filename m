Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A235F1D90AD
	for <fstests@vger.kernel.org>; Mon,  6 Jan 2025 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157626; cv=none; b=OOF4OcBvAns4yuehc2lVFOOECm6pP2Njm+9IhTTIFsD1ZPCsY8fJY7sDccOeKn+w8wWQy+to6jSbqxlOEhOgEXExLy884Ok4b6D5wIFBUCDu6fTbMGMQf7NCk3Fnkh0kWiyFYURIXjHs3TiXACWEC8g0yGQmHYNzW/blFYAA/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157626; c=relaxed/simple;
	bh=mfbRB5EDhI2yJQ9O6Sdiiqq3YpwDHba8FGNZkmNDpkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tPiSwIZetIIJG/wIXRH8RT6IV22RZneyJDOnqtCgylqh5dATvrEht56z1kYMgNdSNNV8N81KdfsGV+bE4yWvjqdEekcCLr0gxO6L24jbpxQmVXCqQinKTaISHNcS3aTGqRZRVbgMmd1uBV7kMx/iftjcblSNgTGmrylCiijz/8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=dAZ8r56T; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="dAZ8r56T"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1736157622; x=1767693622;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mfbRB5EDhI2yJQ9O6Sdiiqq3YpwDHba8FGNZkmNDpkQ=;
  b=dAZ8r56TxpfaYCyZHaP6ckATSoNMDziu7p6YmIn4w8YCzSGg3QhcEZVT
   J/GDzdNlV85MjynbkzPVokFSOAtvW7+Poc5SFTFC9A2OI6ya8mkI3v4rH
   6ojGkee9eh65AHXCqIMOKwxXWCEfTmydvwAEQ+zs3+VgmmhEgWg+iywQC
   6erAUBI8ewXdWl8KpgHTcGsPTj35qnt0EYK/mIAl6NYWtSZXkTHFDW7JK
   WJWpb5ud0eNCp4CgZUpInhgJSJrfVT6wnprIIKPkWj/H7a5CfsQiu5gWs
   hzWm4D8NyYNeLtyve6a436wP3AmsmLUGTHtBIBB2rFM8gxS7qTk0AH4qp
   g==;
X-CSE-ConnectionGUID: Th8I/u51SG6LKtOB0wNXEA==
X-CSE-MsgGUID: 2NmwOoPkRQ6N6qqG1wU4Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11306"; a="164576187"
X-IronPort-AV: E=Sophos;i="6.12,292,1728918000"; 
   d="scan'208";a="164576187"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 18:59:09 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 1483FD6EA9
	for <fstests@vger.kernel.org>; Mon,  6 Jan 2025 18:59:08 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id D4755D504A
	for <fstests@vger.kernel.org>; Mon,  6 Jan 2025 18:59:07 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6702020079545
	for <fstests@vger.kernel.org>; Mon,  6 Jan 2025 18:59:07 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.81])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id D522E1A000B;
	Mon,  6 Jan 2025 17:59:06 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: fstests@vger.kernel.org
Cc: ruansy.fnst@fujitsu.com
Subject: [PATCH] include/builddefs.in: ignore unused-result warning
Date: Mon,  6 Jan 2025 17:59:06 +0800
Message-ID: <20250106095906.330877-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28904.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28904.006
X-TMASE-Result: 10--3.049000-10.000000
X-TMASE-MatchedRID: TWQD+6s80gNXY5ze6zUPKU2xVQmDwU6mn5nfR7I2dFMyiHqxwIX2MaqX
	NKklxta3rYBGlEzRvBCH2FGgJptidkSaaFy3o7RNTuctSpiuWyU2ZWOmuJUS2cZltfe/nRavRi7
	TGiHA9x6C/cGE7/ouQAbBgWAUWNZnlwV2iaAfSWcURSScn+QSXmVV1G+Ck2l7+gtHj7OwNO2eVW
	/ZdL52j0HwGluOMzyRCQJEtxAzKAQRerRMWxF8QmkyZ83xJPcyCSqmvohHUY5yJdY5ZIKfhD1/F
	Vh34Goct2hj5WEghFuqC3j/ikadtIaT7FRqp0wPAcQrAfBh69vBRLFeH6OJSCTDD+DBjuEw
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

When build xfstests, a lot of "unused result" warning are reported:

    [CC] write_log.lo
write_log.c: In function 'wlog_record_write':
write_log.c:205:13: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
  205 |             write(wfile->w_afd, wbuf, reclen);
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
write_log.c:209:13: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
  209 |             write(wfile->w_rfd, wbuf, reclen);
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    [CC] random.lo

Mostly are calused by not using the return value of read()/write()/...
Ignore this warning by adding `-Wno-unused-result` to CCFLAGS.  This
won't cause other problem but make the log clean.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 include/builddefs.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/builddefs.in b/include/builddefs.in
index 7274cde8d..edf87ff00 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -75,7 +75,7 @@ HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
 NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
 HAVE_FICLONE = @have_ficlone@
 
-GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
+GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall -Wno-unused-result
 
 ifeq ($(PKG_PLATFORM),linux)
 PCFLAGS = -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(GCCFLAGS)
-- 
2.43.0

