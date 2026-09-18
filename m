Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DDE3BBA1D
	for <fstests@vger.kernel.org>; Fri, 18 Sep 2026 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752767; cv=none; b=CDUriBfatg+tdNDJPQlZs4C+9SrjlKycT44OeJ15lbHPfnac5vCeT0j5bVIzAAd/rpg1TFgcrYbNz+vnCNeGIomO1ABfnxBG54TRZMdNZydo/FSp3UKB0fJQRRT/qANGeZnqlrZNASxRf6CWxXGx4waBRCIA5pvi4ZqvaouRxNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752767; c=relaxed/simple;
	bh=9zZ3HwtEVrNhpQTGkRilws8lU+X2J/nZxuyHGt74Mzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGSWA10TfXbjsCvCuG48Yu2Vgc8aHIO56tegFyIzkKIeF81pbnunaLygjRWrvEOeGujpbCs/PZ0EZQhBBC+zaT9eP+tNgPcaEKX5KyPXOo3Af1ydLjtepJSsrcTNdGnFcVMQY9+DHgmlsdnPkkw9Ud4QQhVhGdTZD2JNYEMOWrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYAlYSxI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYAlYSxI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456251F0089A;
	Fri, 18 Sep 2026 17:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789752758;
	bh=lPAqntOfE4TYFQPjRj0prJDBclthgrUteUyMJ3a2ndg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KYAlYSxI88Q4AeJfmPGXlUwc9pZlhj9GCHZPYacZ6lA07+Qt/CPRu4jy44TnqWG+C
	 kZYl+lLOnG9W4Tk2CYrxGgKZzrVMWkiZj+81vo50bSP+1gY+z5KK/DIWEOQpLej4+4
	 hHwWlSKx/LJG/ZNJX5PCT/YQrvR7VElQlEx8LvTTVj5c5R4YsYkexOe9RIrpDz+DTM
	 AQyUsLj2G30S/zAUhk6CBkd6SH34dKt3IKYY24Q0dbHNOLU1VL+PiBV5JicLnt21v5
	 oTcBtZaOJSFNM172DyAbQwH+OxAjsvQNvFK682IOGTaPiFj+16rGyNjie1X56b8xTN
	 wMWB/5UX/WlQA==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH 4/4] xfstests: fix permissions on system file installed by libtoolize
Date: Fri, 18 Sep 2026 19:32:09 +0200
Message-ID: <20260918173218.1254465-5-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918173218.1254465-1-aalbersh@kernel.org>
References: <20260918173218.1254465-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Libtoolize installs set of auxiliary files from its system package.
Not all distributions have the same permissions set on these files.
For example, read-only libtoolize system package will copy those
files without write permissions. This causes build to fail as next
line copies ./include/install-sh over ./install-sh which will fail.

Fix this by setting permission explicitly on files copied by libtoolize.

See similar commit in xfsprogs:
6b32423addd2 ("xfsprogs: fix permissions on files installed by libtoolize")

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index a48d8d62f038..6c3de609bf38 100644
--- a/Makefile
+++ b/Makefile
@@ -76,6 +76,9 @@ endif
 
 configure: configure.ac
 	libtoolize -cfi
+	chmod 755 config.guess config.sub install-sh
+	chmod 644 ltmain.sh m4/libtool.m4 m4/ltoptions.m4 m4/ltsugar.m4 \
+		m4/ltversion.m4 m4/lt~obsolete.m4
 	cp include/install-sh .
 	aclocal -I m4
 	autoheader
-- 
2.54.0

