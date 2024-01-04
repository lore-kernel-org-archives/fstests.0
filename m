Received: from synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDC41D68D
	for <fstests@vger.kernel.org>; Thu,  4 Jan 2024 05:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="N0oD5Gl4"
From: Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1704346959; bh=eozqy+HCL7LZkrb4A78DLi2QiyTHWMzjqnWREnsRp/0=;
	h=From:To:Cc:Subject:Date;
	b=N0oD5Gl49C5h4K3yTpILKYq3rLC2jYcAExXex9b/KvcyBro/hywfTXwV15mBryhjl
	 UE9DekrgQar0lV7GF91Ci9wkqLrplXV+eaJY1uI2clK+l6imq9qUYBsdkiadxC4iJZ
	 HF4gm4LCJrs39ha9vLttAgE3NvkYR4KYpuusjsd0=
To: fstests@vger.kernel.org
Cc: shepjeng@gmail.com,
	kernel@cccheng.net,
	Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH] README: add a missing necessary package
Date: Thu,  4 Jan 2024 13:42:36 +0800
Message-Id: <20240104054236.1311678-1-cccheng@synology.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no

src/dbtests.c requires 'gdbm-ndbm.h' or 'ndbm.h', both of which are
supplied by 'libgdbm-compat-dev' in the latest Ubuntu LTS. However,
this package is not a dependency of the currently listed packages.
Therefore, add it explicitly to the necessary packages list.

$ dpkg -L libgdbm-compat-dev
/.
/usr
/usr/include
/usr/include/dbm.h
/usr/include/gdbm-ndbm.h
/usr/include/ndbm.h

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 README | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/README b/README
index e0dabe96503a..c46690c4eabb 100644
--- a/README
+++ b/README
@@ -11,7 +11,8 @@ Ubuntu or Debian
    $ sudo apt-get install acl attr automake bc dbench dump e2fsprogs fio gawk \
         gcc git indent libacl1-dev libaio-dev libcap-dev libgdbm-dev libtool \
         libtool-bin liburing-dev libuuid1 lvm2 make psmisc python3 quota sed \
-        uuid-dev uuid-runtime xfsprogs linux-headers-$(uname -r) sqlite3
+        uuid-dev uuid-runtime xfsprogs linux-headers-$(uname -r) sqlite3 \
+        libgdbm-compat-dev
 
 2. Install packages for the filesystem(s) being tested:
 
-- 
2.34.1

