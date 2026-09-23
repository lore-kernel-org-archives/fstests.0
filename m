Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D81D3B2D04
	for <fstests@vger.kernel.org>; Wed, 23 Sep 2026 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156003; cv=none; b=YWmXCeEsvtrv0JLlP1Hd/N5rLr/uR9NuIJOnABoowqqyNTAsHKfU3KgSZn8IO3GUTmtWB03qODRCMmMqKYtVrPE8WYNX+4MK78+hyLidR4wEsvdcmVsenGUdIaJX80vrb2xSKxxBBEAJ1JdCRKQnfkfbl+oO1oJO1tlLiyl4BuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156003; c=relaxed/simple;
	bh=aTTIXzlwIeYNVGarIEzS/knWaFxA5iplG7KPC6IDv9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbtJTfpzCb6ZmGOY23ZUCj0zJWDMH6+7TjCf9vmhz4prkeX0UY4MgAA2m9bP2PUAlFiSzdW0b60O6Ly3qqd+XM9/Z3LjjC56iC0Q0gdZBUhpfjXEuAitPv4bu7VgoxnRJRn1+jeiAHavqzfiEKhdWcchbjy2jNqGm8GLZRUL6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDKOtI99; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDKOtI99"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1A81F000FF;
	Wed, 23 Sep 2026 09:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790156002;
	bh=R9eJNOiXIpL9V+W9oZ9q0R2bcGoXRQ0c/m9nVC7O2dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hDKOtI993F6jbpPV6cMgF7j4nZ/P/1KLbYlkn43QfnZXSNzXJCFkSEWeb9hGnwUyi
	 mFuas7YTlAMlt2S1NjgkjDFoK05795nyn59SJDvtrNYHkWF72NbBJopJU6ibCcWzsA
	 pWqUhjZiGP//TF1/vuhRgcXBAKGH5AChEzH33XdK/YeutODRdG4VuFz51LuBBsYLyu
	 IyoF99h52+jG7o9aAwteX6bPVWMp8Ci9Q9fqhfPEeF62CLIIe3GagnZDOeyzFjHHlR
	 Rnk4Abn1VxmkMyO7EDWWx9XErxRWlNGgyM+4C2BB5KReVoUXLCiJYwP2siAVVeVjM+
	 KveIij3rmv0+A==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 4/4] xfstests: fix permissions on system file installed by libtoolize
Date: Wed, 23 Sep 2026 11:32:55 +0200
Message-ID: <20260923093259.16199-5-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923093259.16199-1-aalbersh@kernel.org>
References: <20260923093259.16199-1-aalbersh@kernel.org>
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

