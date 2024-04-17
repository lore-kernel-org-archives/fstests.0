Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31681BF53
	for <fstests@vger.kernel.org>; Wed, 17 Apr 2024 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713382507; cv=none; b=rUkrgunz0o2YwBErnZbZpRm51oDtUTlk1MAQL6TIencDHH6H6SBwZsmDpM/AhGBoKVgG+Ptt58hgLLvIg77KpBeFPrVqqwVCUHwyYTOMfPrvajxHZ4G2Az8d43t5QCpr0cNQ4GjtKmbr65m0/D2FkXmiue45KkOV5odYIXRENzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713382507; c=relaxed/simple;
	bh=t1LI4uFe6h7QWmvdJF1QRAnZyhwOhmlzPQ3qzotm4Ok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gyLTdRVnI96ZOn3Yw9GNdjf/ybq7ftTR/HSUP3JR/feNYdwYFENb7FPIRFVgYRAUzqe4csjrlL1VbADGbr8smuBdLMnivzpLvg9rEZk5O0LQ6+NyN/Gkyhp/MJFIQVcmqyzf2EXU3KCzTMo8nEaoipGvOGdoXp4pxs6G/f/V/HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dz2r/+2+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dz2r/+2+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61154C072AA;
	Wed, 17 Apr 2024 19:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713382507;
	bh=t1LI4uFe6h7QWmvdJF1QRAnZyhwOhmlzPQ3qzotm4Ok=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=dz2r/+2+MXCDS0gbrgQOmLtG7K2OcAhovl4NJVoLSNH0BZFjqLzW7z8x9fo6G6mfn
	 qTI19DvdyxocTm0rcRXvjy8Z3SgdtAT8CZnNavJ1fj6yza37RXAbELhBrNGKl6h0Fj
	 PVFFmerjyoF34lV2XJgYXzI/HDTRAhfQGxF0AIfyQ1jzL0yGSbAhVKhDNCjAC0Ejou
	 ouZXzjyxuhqOq9a5jN2LzyKDMrKg0b6iKNLwDv1kabdgX5Boq+qZxTEpi9AA8s5JIn
	 z+mAb93Rz4F6SQ0J57ZYDCYhJuRmoK4zZnoWWx/k7Z8ofKplvDChl/1e2sNxvtKljC
	 5qejI791oN6ig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA6EC4345F;
	Wed, 17 Apr 2024 19:35:07 +0000 (UTC)
From: Taylor Jackson via B4 Relay <devnull+tjackson9431.gmail.com@kernel.org>
Date: Wed, 17 Apr 2024 19:34:24 +0000
Subject: [PATCH] generic/645: Add hint for expected failure with old kernel
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240417-generic-test-645-v1-1-7f6f496af06a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAD8kIGYC/x3MQQqAIBBA0avErBvQSTO6SrQInWo2FioRRHdPW
 v7F+w9kTsIZxuaBxJdkOWIN3Tbg9yVujBJqAykyymiHG8cqPBbOBXtjUQ/OqqDIUsdQ2Zl4lft
 fTvP7fk25UwViAAAA
To: fstests@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, 
 Seth Forshee <sforshee@kernel.org>, Taylor Jackson <tjackson9431@gmail.com>, 
 Zorro Lang <zlang@redhat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713382506; l=1100;
 i=tjackson9431@gmail.com; s=20240206; h=from:subject:message-id;
 bh=rNdH0c61gNgISeRXRPFYYO+c6i1S4rlqeXA+MtehszM=;
 b=aOMZYB6wtyZDA5Pkb6xeHV4orfPQemndp/bMkenvJMErmglLVYwOtRfDdlhuPNb3lFSPCbOJa
 jk/2M4JmcUuCMRCLjh1mOTqFYryxqxabBEmod/rvpoWKYTaM3FEyvgP
X-Developer-Key: i=tjackson9431@gmail.com; a=ed25519;
 pk=NO7ntQpjIG1IGTO7F8OnLJDKSHUakhrhAli+PL72OLA=
X-Endpoint-Received: by B4 Relay for tjackson9431@gmail.com/20240206 with
 auth_id=145
X-Original-From: Taylor Jackson <tjackson9431@gmail.com>
Reply-To: tjackson9431@gmail.com

From: Taylor Jackson <tjackson9431@gmail.com>

The following hint is added to reflect that any old kernel
without kernel commit dacfd001eaf2 (“fs/mnt_idmapping.c: Return
-EINVAL when no map is written”) is expected to fail this generic
645 test since without that commit, mount_setattr won’t return
EINVAL when attempting to create an idmapped mount using a user
namespace with no mappings.

Reported-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Taylor Jackson <tjackson9431@gmail.com>
---
 tests/generic/645 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/generic/645 b/tests/generic/645
index 556d2450..bcc3e3b5 100755
--- a/tests/generic/645
+++ b/tests/generic/645
@@ -17,6 +17,8 @@ _begin_fstest auto quick idmapped mount
 _supported_fs generic
 _require_idmapped_mounts
 _require_test
+_fixed_by_kernel_commit dacfd001eaf2 \
+	"fs/mnt_idmapping.c: Return -EINVAL when no map is written"
 
 echo "Silence is golden"
 

---
base-commit: e72e052d56c3f05e533f4b67056f86931f688368
change-id: 20240417-generic-test-645-18750d02523e

Best regards,
-- 
Taylor Jackson <tjackson9431@gmail.com>


