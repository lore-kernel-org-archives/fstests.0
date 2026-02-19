Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FA73033FD;
	Thu, 19 Feb 2026 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771514756; cv=none; b=h/UQuLgN3iKO7sL2ukmGT8uHPSzx2h6eXkshRMKjDTk2V8Rqfi+UXKVECYOVxIqaiAP0fCuHhGEqdj5h3DuBxd23WUQeQekadz4KAGCTAat9p6u9R/zslXQ0nyj1NVJ8G5CqrenvU55rG40M2rdmFprvefk0eXImQKZNqbt6YIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771514756; c=relaxed/simple;
	bh=dK7v+5h9Vw/NBpLSdUNCXWAsTpedsxQ39fAauyPKfHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q9WYB9oV4dvWskHfQEKYIOt3ZvZI0qZlhEgk62L3izzfeHieHvFsva9wyMUkGf8tneb2rtooMYhXG75n+v9xFrbXr+r03aLT30w+xvDGa7GpwWDujuMmo+tu8qyukgDD+nqmm04gHMxPZ4XmYtb66TNJxwwHgewPANmyHAvAc5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJwsF6Wk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJwsF6Wk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFEFC116C6;
	Thu, 19 Feb 2026 15:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771514755;
	bh=dK7v+5h9Vw/NBpLSdUNCXWAsTpedsxQ39fAauyPKfHE=;
	h=From:To:Cc:Subject:Date:From;
	b=OJwsF6WkUl0naWaTKQ9BYlOS7HQYH89CZuNeffzDBYg4P4NCKGCr35NabVsTCmEFe
	 1YjjhP9/mI/Qq29gT0r10tK9gdRK8D+P52b+1zEpqUhAg086Zj28LdSZ/Ip5Qt3RL9
	 ipZENJvBxGF7C808crqON8X8gYR9GAW3wGX4ubUFLzk6j2ZGJafzx5AsRfohqBkZAl
	 K2p59hSIHBHZ3YatPSU8mAS7bmMb7dRyhoPQbVeB7GrIpQLvMplQ72d+EWdi1DaVHk
	 Wx0njWbYl4sewIbaW5Sh+dLWHHox+SfGLsoqnexCuZ+upZULsLCryW9HyJQaogSy6r
	 5zWR1Kl6EF/uQ==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org,
	fsverity@lists.linux.dev,
	zlang@redhat.com
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	ebiggers@kernel.org
Subject: [PATCH] generi/579: handle quoted cmp output
Date: Thu, 19 Feb 2026 16:25:22 +0100
Message-ID: <20260219152524.1770469-1-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diffutils updated cmp with more consistent quoting in commit:

	69ae797392bd cmp,diff,diff3,sdiff: quote more consistently

This causes generic/579 to fail from time to time due to grep not
catching these errors. Remove quote to work with new and old version of
cmp.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 tests/generic/579 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/579 b/tests/generic/579
index d5fab4892e9a..19ffd4954db2 100755
--- a/tests/generic/579
+++ b/tests/generic/579
@@ -71,6 +71,7 @@ for ((proc = 0; proc < nproc_reader; proc++)); do
 			# match, regardless of whether verity has been enabled
 			# or not yet (or is currently being enabled).
 			cmp $orig_file $fsv_file |& _filter_scratch | \
+				sed "s/'//g" | \
 				grep -v "SCRATCH_MNT/fsv$i: No such file or directory" | \
 				grep -v "EOF on SCRATCH_MNT/fsv$i"
 
-- 
2.51.2

