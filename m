Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F12C13D50C
	for <fstests@vger.kernel.org>; Tue, 26 Mar 2024 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485237; cv=none; b=VNUrt7nfIO17c03KwOa0D3jGrxfuWokEVwOylNfjmRTlxfvo7NvhJtsfTRIu3XTKHYnf5an0BQA8oscUJlVQWpkR7GS+NuwuhGbGckgMflBrOs5IL9EPiAXi+XxPyUvAJJG03D+2LgDxyWhNImJFxPvdwk/uHALJUBOGgoI8Wno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485237; c=relaxed/simple;
	bh=PMxWRHdvu3D8YQkMSw7UxQB8NcT07jaMLKw5AW6qsVA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MqTGDO4FdX7tQjjIy7NFu5iYmf61XHbAON4qY65iyN621MDn8Sx0c9BGPh9H5m9GvQRfgvETRFtDGgNjMfF0bPaGro9xL3zaouZni19Kal0FhGTe/Vl9n2sxgvAMuO3gYhBCw7Y35G3leHxZNxY5u0dthiMUQL/c6qRMzv7ZPS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afUd/3SG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afUd/3SG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 364FEC433F1;
	Tue, 26 Mar 2024 20:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711485237;
	bh=PMxWRHdvu3D8YQkMSw7UxQB8NcT07jaMLKw5AW6qsVA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=afUd/3SGpMPxEfWdqQhyuWF+fNvqWfI3Limbx2eoYO/nNVJxzcZ238N37RoI7gww2
	 MlhWofUchHNzjwdkn7H6nbNKvpBzP+pPX5NiBJuC6p4WvOLwDUNcdHditM/54yY8Zd
	 hAGVsF+sL+ZtO9T9bPDR3x+M+q3WoECnnx/MI8NKM6P8GYWQnXIaZr56K77t2YZjrS
	 9gG7J9kJuuw/Ht1OHocrEFhjd6iErEK6GZoaT2fJ+7VRalQVyZSlAE13ZJG21vjQUU
	 vrC4JGqFE2fJdJXGL05Wn+wymYROdZbrixsuL10U6XK7kxZxJz4MiKC/Bd0G3j2T7g
	 CXgXpjnv1g6Fw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC23CD11DF;
	Tue, 26 Mar 2024 20:33:57 +0000 (UTC)
From: Taylor Jackson via B4 Relay <devnull+tjackson9431.gmail.com@kernel.org>
Subject: [PATCH 0/2] Patches to update xfs test "generic/645" for
 mount_setattr
Date: Tue, 26 Mar 2024 20:33:50 +0000
Message-Id: <20240326-mount-setattr-test-v1-0-c061b040d0f7@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC4xA2YC/x3MQQqDQAxA0atI1gZiHKr2KuJisGmbhWOZxCKId
 3dw+Rb/H2CSVQye1QFZ/mq6poKmrmD+xvQR1FcxMHGglh+4rFtyNPHontHFHAcaAoeO5p4JSvj
 L8tb9no7TeV4bHpMcZAAAAA==
To: fstests@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, 
 Seth Forshee <sforshee@kernel.org>, Taylor Jackson <tjackson9431@gmail.com>, 
 kernel test robot <oliver.sang@intel.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711485236; l=835;
 i=tjackson9431@gmail.com; s=20240206; h=from:subject:message-id;
 bh=PMxWRHdvu3D8YQkMSw7UxQB8NcT07jaMLKw5AW6qsVA=;
 b=SPKYaSZcsgzRgXMpio/t7r2Pt5e/Q9GmtvFAxgnKm1oF0dbjXgDG2E7hxm5y8p9FM4ljF0IM7
 mSdgNikKDEVDmJw9z5jjM/FmgPFtCj+B3aQ0l+kjXSEekAdp2gSH2Ce
X-Developer-Key: i=tjackson9431@gmail.com; a=ed25519;
 pk=NO7ntQpjIG1IGTO7F8OnLJDKSHUakhrhAli+PL72OLA=
X-Endpoint-Received: by B4 Relay for tjackson9431@gmail.com/20240206 with
 auth_id=145
X-Original-From: Taylor Jackson <tjackson9431@gmail.com>
Reply-To: tjackson9431@gmail.com

The following patches fix the "generic/645" xfs test which was 
affected by the mount_setattr change in kernel commit dacfd001eaf2 
(“fs/mnt_idmapping.c: Return -EINVAL when no map is written”). 

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202402191416.17ec9160-oliver.sang@intel.com
Signed-off-by: Taylor Jackson <tjackson9431@gmail.com>
---
Taylor Jackson (2):
      vfs/idmapped_mounts.c: Incorrect array index for nested user ns
      vfs/idmapped_mounts.c: Change mount_setattr expected output

 src/vfs/idmapped-mounts.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)
---
base-commit: 9b6df9a01ac8ee3f28a2a24d71e45792e21b6d48
change-id: 20240326-mount-setattr-test-90942470c820

Best regards,
-- 
Taylor Jackson <tjackson9431@gmail.com>


