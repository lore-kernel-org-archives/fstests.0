Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3651C1607BC
	for <fstests@vger.kernel.org>; Mon,  1 Jul 2024 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845523; cv=none; b=aBSFdfVlmFTjMol1JM4vz6Gm6gExl+LaC9QfbRxUudoil2OIx/qLsHgwKyk8y4dEVSDkK7lIrcXn+7G9FWBoa/5jnoaHZOqVTOxAtITfW94vEPedgSOYGzRKjV1Lf9zF5L9EmcqklvYpXIMpXAdS53pZ/Ou9sfjfji+fQ1YtwhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845523; c=relaxed/simple;
	bh=iEQh3A6ebmSPauoPzDsyENd/8vTE7Uwu/TkFmIBfxPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YRPa0iFrYuQoGBOTK4hjLwdrRiUTAKWaogd52sZShCBW/bCdx8J9fu4+tctmL9u7lwrzPgJlHrdXjz+uZQCb7FmV16rQxIAD0u0CTUh0U0vcFcP3c15LnhRfTMaPv+CukkXFxgMYPB57UQ+vgZQ6g3woeC+om8NKbqEL5Vq8VbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdl8WjDE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdl8WjDE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC30FC2BD10;
	Mon,  1 Jul 2024 14:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719845522;
	bh=iEQh3A6ebmSPauoPzDsyENd/8vTE7Uwu/TkFmIBfxPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jdl8WjDEkfuV847SXBqlJtv9VajqO9smtMy36eiM2w8UPFrXh2xlMVbnQjRird6/c
	 aI9dAXTA4B12M6iFroDECb8uGPhEuyvwsIbuoawEA/KleJ5V1uNRegkTLnok/TNz7z
	 AGT4jZ1wH2mQBWSjyJBDog235m765cAv4tq2oaa3xPq1OdyHniM7pL/NI4jO3PvuoF
	 ZfhLca0j/R5kNzti6owkJqtLsJnlNY28URKRQBgVPrPn0KR5SANExAHTaVwGCRE9fZ
	 7GWG2d9PdLLfjtbPiT9QsXBepqhoBx2YdhHNEhkiXlAkUNTQdntLqnsgmQzu0sDYhP
	 B5Lap/XE4ftig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F1BC3065A;
	Mon,  1 Jul 2024 14:52:02 +0000 (UTC)
From: Daniel Gomez via B4 Relay <devnull+da.gomez.samsung.com@kernel.org>
Date: Sun, 30 Jun 2024 23:52:40 +0200
Subject: [PATCH v2 1/5] common/config: fix RECREATE_TEST_DEV initialization
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240630-common-fixes-v2-1-16d26fb1dee0@samsung.com>
References: <20240630-common-fixes-v2-0-16d26fb1dee0@samsung.com>
In-Reply-To: <20240630-common-fixes-v2-0-16d26fb1dee0@samsung.com>
To: fstests@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@redhat.com>, 
 mcgrof@kernel.org, gost.dev@samsung.com, 
 Samsung Samsung <"Daniel Gomez d+samsung"@kruces.com>, 
 Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719784382; l=996;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=CZBncsstQuBprsTkh+ba7qAwTYuluS865arve8XzUjg=;
 b=x0nrkTnmEGQsXr88t+voL8wIX+aZVsb4Z6MqR8eeX++5XJfaL9vK86soHVvdp7dlM96TyD3B+
 lE2yZztDPUhD2VhVioh/UVSZTNDeL71HWiIO3TrLFCFB9KOrnHQij1+
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
X-Endpoint-Received: by B4 Relay for da.gomez@samsung.com/20240621 with
 auth_id=175
X-Original-From: Daniel Gomez <da.gomez@samsung.com>
Reply-To: da.gomez@samsung.com

From: Daniel Gomez <da.gomez@samsung.com>

Do not allow the overwriting of the RECREATE_TEST_DEV variable. When
this variable is enabled, common/rc -> common/config will reset it
to false after the test device recreation process. This allows for
differentiation in mount options for SCRATCH and TEST.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Zorro Lang <zlang@redhat.com>
---
 common/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/config b/common/config
index a1cd14de6..43b32b93d 100644
--- a/common/config
+++ b/common/config
@@ -94,7 +94,7 @@ export PWD=`pwd`
 export MALLOCLIB=${MALLOCLIB:=/usr/lib/libefence.a}
 export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
 
-export RECREATE_TEST_DEV=false
+export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}
 
 # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
 set_mkfs_prog_path_with_opts()

-- 
2.43.0


