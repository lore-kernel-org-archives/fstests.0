Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7623E31ED83
	for <fstests@vger.kernel.org>; Thu,  9 Jul 2026 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595935; cv=none; b=BAfrIDxEosks3DpuJ6di2V63vWxKhmswFhLD3jqaFlnWu7UeeK0A9YEppanGAuSb9JB7yYgm1suwCll7Ha0Qiw4RmmSuURTWE8n9+oqovg1G5CFbZplDFOc9ar+anD5wMTvpviv56a0eOyskSS0S/5PvZYek9jZ9JO5i5+Pwxnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595935; c=relaxed/simple;
	bh=6jY51bUjxOWlgNrwYEpZfW4pT0usZ4oALmFFQddxfXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k3RIXqB1F5keTrzvDhUxUW4Iw1wEN1moClmgnGb+EmK85WEAx0OQ0QTv+0szElMW5o2brmCCx3AIf7QXGCLBDEJs7blr5uhQCrqyNuYTZVS6GJkxm6oEbY7WCCEP7Czekn7E2lW695IhTp/7YbZxNaDAuMGw+JhlSYDT8xjmazU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8R4UDXu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8R4UDXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E491F000E9;
	Thu,  9 Jul 2026 11:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783595934;
	bh=AyOl20NpgfRwiV9+D9JFk0ga3AqiCozmSuJf6M/w1lI=;
	h=From:To:Cc:Subject:Date;
	b=i8R4UDXu3lltGYZb7dwfb7u5M5sVC+gpR7BrA/sfWg+77vldYwz8a4w69JLAqSgQL
	 bhe91Oy+QsK1p8mfNHWNnXqjn6Hqya7Gsz5Rn71eNbrRGeNsTariBHKtVItgDqm0De
	 Sro5oA5+5vOaU2XtRISXV78NU+A+o9Tutir+xfnVyP1J2I1RQGm+40i2l5K/8Eqqye
	 Huibykiwm4u8Rz/R8Q08SPJqI/VuEwvmeLiKNd8VIs9vNAJHsB4UM6TLb7hZeA+fCs
	 43gtawzcOlLW7SfKKeYdX4wp/hCLPK9w3hR70RR/e7mIMv4F4YvjIy8m7G6TcfOl7B
	 IsR/cg4lfeH4w==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH] generic/270: kill fsstress by exact name
Date: Thu,  9 Jul 2026 13:18:47 +0200
Message-ID: <20260709111847.2842394-1-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running ./check with fsstress in the arguments (for example -x
fsstress_scrub) causes pkill to kill parent bash process executing the
tests. The test suite execution just stops with:

xfstests-start[4099970]: Terminated                 _run_seq 2>&1 | tee $tmp.out
xfstests-start[4099970]: Ran: generic/269 generic/270
xfstests-start[4102535]: Interrupted!
xfstests-start[4102538]: Interrupted!

Fix by using exact name, we can not use _pkill_fsstress here as this
test copies fsstress binary under custom name.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 tests/generic/270 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/270 b/tests/generic/270
index 9ac829a7379f..73464f02d3d9 100755
--- a/tests/generic/270
+++ b/tests/generic/270
@@ -50,7 +50,7 @@ _workout()
 		sleep $enospc_time
 	done
 
-	_pkill -PIPE -f fsstress
+	_pkill -PIPE -f "$tmp.fsstress.bin"
 	wait $_FSSTRESS_PID
 	return 0
 }
-- 
2.54.0

