Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDD8346E47
	for <fstests@vger.kernel.org>; Fri, 25 Sep 2026 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333127; cv=none; b=ExQd+TX/rhsRVR2FfRr9bogHjaN3WljZ4yzZSTOtuNRzDC82qA2zIlNS5YPAgmNFW1DYaYbgVIx7WWqSfThC4iUORmKF9xMeg8k710ObBsIelfGga3eHlh4/UKt/F2WJlN0aUF7kaDXpRDTvu/S34zV1XVQFrCXRMqOjwNuxpKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333127; c=relaxed/simple;
	bh=aTTIXzlwIeYNVGarIEzS/knWaFxA5iplG7KPC6IDv9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKC7jFK0yllDlWkvM4LpKnKUW68fh4lHS+ef5mKhy+nPyil9Y1pL4UXQdrHiTdomOsm69efrZNstFo01gdF0c691fQgcTPxJRVU29lrPbs2p110+LQsUd1eapWhbvuEbdvZhrCUYfCH00FS1gdnHZkMGxkHRMztpauG3aI5d0/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzClRhmg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzClRhmg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE8A1F0089A;
	Fri, 25 Sep 2026 10:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790333125;
	bh=R9eJNOiXIpL9V+W9oZ9q0R2bcGoXRQ0c/m9nVC7O2dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LzClRhmgY+ovUf8d+3ROM0Xlzui8kXcyn+knYf2WwglnRdHbfcGvehbZpnVNpLQWH
	 fYT4eUmf4Bds5jP9EOn4qKbpW+ZVrNKt4YLUGNA4VlzhZT9NXoUokB2nn2cyzeLkoz
	 76EWmr49ATElYUQ96X4l5MoNbB9KvIWQ0SwpLLyhyLgbEhDzchD8hKCroTGU5+Ts3f
	 el48YpiTarORhbGQTqkKt6YncQKH2wAm4Q3UPhKzEImiWXL4vATYT0ZVtTp2+T/N4R
	 DfSfVfQcLdaBlSVMQ+mi0gMJWJYAwmNAzK3vz1hG6Lb7SRti0VI6ArMwfeQFWIKQwB
	 xKc8qx39gHWlw==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 4/4] xfstests: fix permissions on system file installed by libtoolize
Date: Fri, 25 Sep 2026 12:45:12 +0200
Message-ID: <20260925104514.664260-5-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925104514.664260-1-aalbersh@kernel.org>
References: <20260925104514.664260-1-aalbersh@kernel.org>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
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

