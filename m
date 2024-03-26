Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0E713D28E
	for <fstests@vger.kernel.org>; Tue, 26 Mar 2024 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485237; cv=none; b=jPb3psL+MiefV0/Mp51uX3NpgaNh72oVNAvkGXHWAzFRSEbUSJnmtpMK4WPCh/Zp16X4/0C8cAsmL/eYyP7lBAqB5NFBXSsv976TE5aplginDbDbelytCNubbDHhsTvrvWYuyY5u3KWseR6VHUUgjCtuGLvraSbDHyDEpjeej4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485237; c=relaxed/simple;
	bh=J53LfGOXaCjeFGCYYuupOZle6kEoD+N/VGasq3MzP4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ftLC08rWQ7O67A+mpQSuSDKD9RCqj69XWpNaoQoICfBq0/W9mnvSGzwSNUYIZwkz4nHxhHEUIIPdTlsWIL2JNMk6sYslB68ow/Tfaa/uWY99Xica5y0UqzI3U1YhYjYuEitemu46jdeDcrMK501vP7eXoUYJlrwJTpgzl0EfL5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccAOxVXJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccAOxVXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40A77C433C7;
	Tue, 26 Mar 2024 20:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711485237;
	bh=J53LfGOXaCjeFGCYYuupOZle6kEoD+N/VGasq3MzP4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ccAOxVXJllCd9W9YjB17DXQ2xlk6bRHGrOPJh6/vDNu4uAcmsGXpsCo9dE7lYEEDy
	 CYf15Mrf/EPSp1EqTelOLE78xtI/HkE4iNAZvfxQMXgfVnmkGR/d6rcrh95nZN2DnK
	 2gbip+oJ3CeqNh5oZyZml4yWPs7RkD1YuP7DQbOIDAieIQbR8TaDNrhDP+TY4cWIwc
	 k1nxYPG5uyu7K1teOoUsxJ5Sszqv2wFfsu2AkftdWVUR8wkBH8F1GQWiRVnp0z/iaj
	 I6fiPX6SOlnRWK0F5wAoqbVdEPwVMtU6lZmIFwICNDdTqhxACITgbCLMAVHB5KDwZn
	 g2OGYLUQer64A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB60C54E67;
	Tue, 26 Mar 2024 20:33:57 +0000 (UTC)
From: Taylor Jackson via B4 Relay <devnull+tjackson9431.gmail.com@kernel.org>
Date: Tue, 26 Mar 2024 20:33:51 +0000
Subject: [PATCH 1/2] vfs/idmapped_mounts.c: Incorrect array index for
 nested user ns
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-mount-setattr-test-v1-1-c061b040d0f7@gmail.com>
References: <20240326-mount-setattr-test-v1-0-c061b040d0f7@gmail.com>
In-Reply-To: <20240326-mount-setattr-test-v1-0-c061b040d0f7@gmail.com>
To: fstests@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, 
 Seth Forshee <sforshee@kernel.org>, Taylor Jackson <tjackson9431@gmail.com>, 
 kernel test robot <oliver.sang@intel.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711485236; l=997;
 i=tjackson9431@gmail.com; s=20240206; h=from:subject:message-id;
 bh=BKnBnlQxMR6w2lLKErcrcTyWMWPn+55we5Ja40IlR0M=;
 b=Tc2NSJaI/jjx2h2N++FNwEVoviaql9msmHiGB/4Cp0TYGrg0TbYUHLw3hVC5kZKu3iF4Egz6Z
 80LD7eHGYvqABQm4fNwPF46Plu+cwyCwsdED+6PoA0o56yVeeeT5fZU
X-Developer-Key: i=tjackson9431@gmail.com; a=ed25519;
 pk=NO7ntQpjIG1IGTO7F8OnLJDKSHUakhrhAli+PL72OLA=
X-Endpoint-Received: by B4 Relay for tjackson9431@gmail.com/20240206 with
 auth_id=145
X-Original-From: Taylor Jackson <tjackson9431@gmail.com>
Reply-To: tjackson9431@gmail.com

From: Taylor Jackson <tjackson9431@gmail.com>

Within the vfs test for idmapped mounts, the function nested_userns()
is using an incorrect array index when attempting to set up the mapping
for the 4th nested user ns within hierarchy[4]. The correct index that
belongs to the 4th nested user ns is actually hierarchy[3].
And hierarchy[4] is reserved for the dummy entry that marks the end
of the array.

Signed-off-by: Taylor Jackson <tjackson9431@gmail.com>
---
 src/vfs/idmapped-mounts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
index 547182fe..34052ca3 100644
--- a/src/vfs/idmapped-mounts.c
+++ b/src/vfs/idmapped-mounts.c
@@ -6556,7 +6556,7 @@ static int nested_userns(const struct vfstest_info *info)
 	}
 
 	/* Don't write a mapping in the 4th userns. */
-	list_empty(&hierarchy[4].id_map);
+	list_empty(&hierarchy[3].id_map);
 
 	/* Create the actual userns hierarchy. */
 	ret = create_userns_hierarchy(hierarchy);

-- 
2.34.1


