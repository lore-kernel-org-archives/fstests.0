Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59FE13D537
	for <fstests@vger.kernel.org>; Tue, 26 Mar 2024 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485237; cv=none; b=hvvgmfDkugDhXEsXbiUvLKVC9242qoHaECCGKADCwWRXJSnQ15UeLnx3ZC/mUit+Q/2r4Za4QbXKtcnLx+rELh3jsuh5/s55NSk9BQzO+lc39f5joONe794jsjrSn4/K6BzPe40P77dQAvF/iGGh1voqQCg4rNTdJcbLfCMDAlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485237; c=relaxed/simple;
	bh=pXk+NpAOBrH2BZU+ERvSkplmhqIvqC1ZbTpd5h+82Qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WKLillvMncYesPbuNa/eDDPPyn+pNw9o0Q9ZScoPNmsvy2FGkLYt+meRVcyJ0Jt2m9Q/HtQ6m04KHyOvjz72IimlpTx9VJwLo0KoGy+6or1c3XSOfyLa+kjUEV7kB0J7sA2pQwWfMgPy+wxoEwbZ/JdEEfq6AYq4wV43IIw4P0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6zsDKgi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6zsDKgi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E374C43394;
	Tue, 26 Mar 2024 20:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711485237;
	bh=pXk+NpAOBrH2BZU+ERvSkplmhqIvqC1ZbTpd5h+82Qg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=E6zsDKgiNbo3QB0j1nNd+AK2FqbXq2QXvJhrOfv7ANJ/cahs18bWAiot9RDcTBGh/
	 ieSW6/j+ZCLaK8wXky+hLwd7x4/jfDKCoqkxIsP56S5NotBlTMGZfEloAqJfvxOHWm
	 rKj2OET/qlJZGGxydc2hECGC7UVB826iTJ3ewgGJZCU4sl8qgRWfHQxDaZL7SdbuOF
	 b2Zv0rvhXMIHBwvM4ycrQD6kXVR2D+u6TDziJTLvdM/O6KnQQp6kmZVQ9LCrqiPRQF
	 tDqqq7jgQOI+cjBb7RwwrG27uVwee5pwrKCdg5szbabaNuKf7o7bq3p4UoS9qY+gc8
	 j1Rf2ZX0FXgMg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A2CCD1283;
	Tue, 26 Mar 2024 20:33:57 +0000 (UTC)
From: Taylor Jackson via B4 Relay <devnull+tjackson9431.gmail.com@kernel.org>
Date: Tue, 26 Mar 2024 20:33:52 +0000
Subject: [PATCH 2/2] vfs/idmapped_mounts.c: Change mount_setattr expected
 output
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240326-mount-setattr-test-v1-2-c061b040d0f7@gmail.com>
References: <20240326-mount-setattr-test-v1-0-c061b040d0f7@gmail.com>
In-Reply-To: <20240326-mount-setattr-test-v1-0-c061b040d0f7@gmail.com>
To: fstests@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, 
 Seth Forshee <sforshee@kernel.org>, Taylor Jackson <tjackson9431@gmail.com>, 
 kernel test robot <oliver.sang@intel.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711485236; l=1608;
 i=tjackson9431@gmail.com; s=20240206; h=from:subject:message-id;
 bh=2hauqK72ItpVFiPIDTfm1+0Ak2rYzw7tFM3DP+H91uU=;
 b=sV5+jr4uCvsdK+uySs+MkAtagvqhBfdDtpJAWq8BurlIHYhWzLvNwre8oLUPmkW3mtZzTsQ4f
 CsZDldH5ELMBoO1nKCet2/npXcUL8+l38Icj2mQk9G99mR8xHpDw0gw
X-Developer-Key: i=tjackson9431@gmail.com; a=ed25519;
 pk=NO7ntQpjIG1IGTO7F8OnLJDKSHUakhrhAli+PL72OLA=
X-Endpoint-Received: by B4 Relay for tjackson9431@gmail.com/20240206 with
 auth_id=145
X-Original-From: Taylor Jackson <tjackson9431@gmail.com>
Reply-To: tjackson9431@gmail.com

From: Taylor Jackson <tjackson9431@gmail.com>

In kernel commit dacfd001eaf2 (“fs/mnt_idmapping.c: Return -EINVAL
when no map is written”), the behavior of mount_setattr changed to
return EINVAL when attempting to create an idmapped mount when using
a user namespace with no mappings. The following commit updates the test
to expect no mount to be created in that case. And since no mount is created,
this commit also removes the check for overflow IDs because it does not make
sense to check for overflow IDs for a mount that was not created.

Signed-off-by: Taylor Jackson <tjackson9431@gmail.com>
---
 src/vfs/idmapped-mounts.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
index 34052ca3..f4dfc3f3 100644
--- a/src/vfs/idmapped-mounts.c
+++ b/src/vfs/idmapped-mounts.c
@@ -6667,7 +6667,7 @@ static int nested_userns(const struct vfstest_info *info)
 	}
 
 	if (sys_mount_setattr(fd_open_tree_level4, "", AT_EMPTY_PATH,
-			      &attr_level4, sizeof(attr_level4))) {
+			      &attr_level4, sizeof(attr_level4)) != -1 || errno != EINVAL) {
 		log_stderr("failure: sys_mount_setattr");
 		goto out;
 	}
@@ -6706,11 +6706,6 @@ static int nested_userns(const struct vfstest_info *info)
 			log_stderr("failure: check ownership %s", file);
 			goto out;
 		}
-
-		if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid)) {
-			log_stderr("failure: check ownership %s", file);
-			goto out;
-		}
 	}
 
 	/* Verify that ownership looks correct for callers in the first userns. */

-- 
2.34.1


