Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F68621A42B
	for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 22:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746051040; cv=none; b=sSs/usYVESfzczAUCbIKMHykwTmCDVEUwHKkitVdRs5c6QcfbKX6LAbHX5lKVeHqm48yOVcuuZVi4mTTroLaveD77IdqbzpaSbt3YnE24y/Lw7sOcWDFAlBYnWcSoqywLnMyuqEgAHqSR1Gdt9nwmPkY1vx5d+jPhxVwZBwnbP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746051040; c=relaxed/simple;
	bh=QJluASJUoIRekmGbs8byeQP1zA2r+5tvkgu1AYBzr7o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=M9qEqVciUJP+tqBVBCyDJkoWI/P3+vAWC6eRbI+MPxlmh//NaMY/VvAm2TdCEi7KJlqyKNiwOMh7nTOAl84E/gCRZhDQyTks1BiZ2Hu01wwRGg8YIn004FW9Exfi4T7GDXQlDUi9pNDkTA9hytFuIEuB7qLp6KSaXd3cpSi2mS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=LLeX4DVD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AXfYuv/1; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="LLeX4DVD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AXfYuv/1"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 2C6B5114018A;
	Wed, 30 Apr 2025 18:10:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 30 Apr 2025 18:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1746051037; x=1746137437; bh=08
	D6xmpV1zGWc6ebcYZ0rXE86G7IScdYeWebRMDsKMs=; b=LLeX4DVDX7BbCW0xFp
	8HvRFtg/itSLrfc3Q3Kj0c92J3XSF0E9OzG8oUbMymTdUekMYUoNR6U63lv+f6PM
	zv0LjUsl1nk25pf2wEOoGJ2leOT9W4l+0s0IuLoyTLurDKpaVN1yf9cwWJRJuaVg
	Ol9FvDo+0lAh+T5MFDAwE219CXGPczCLSmaGkPbuv+TGlg5zmNDqQ5gbFc4Zu2+w
	zBHLaKgfZXNkQWt+NcXphsuGicFzJZ/WBuLADEwX6wf3TZZBqZe7C2bR3nkslMlp
	MAprDomH9X1DLj3Btuw+Tbr143V83zNlYr6bwx5N1lrfQfSmE4pX6pBteEnHKJUy
	jSjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746051037; x=1746137437; bh=08D6xmpV1zGWc6ebcYZ0rXE86G7I
	ScdYeWebRMDsKMs=; b=AXfYuv/1oyh6e/f4nkebE7y3h43bxY0OPVaBNaC3OJje
	6XK6OIX1lMBYIj2hGLQvsoppDprayymveny1xZpsibbiiB/hhj6EkisvmlKNeBI8
	X2mwF+f7+Q447ShugoIXLCN13d5q5jzTCSsnohvdyAoQ8YD2SDRIVx8MddALTxxF
	H5ZaH1mRL5OFGVYLxJv10uEmLZLnJzHQh9oipljXOyw0yGGFQXIzWtveF5xbbecR
	+ebleGhL7OZr+JhraoC0sHhYxKh5nhLpqz8bGilknxrqRqSGNMwd3RpRmrxBlByx
	VwTdg7V1d9vE7Q38efVWd1TEG2b3NgCYBCzOtt51PQ==
X-ME-Sender: <xms:3J8SaJJHqAD_8cTJzYzmzVPBrjYni94Fk4vAlGEbL_SPFRpvERyZSA>
    <xme:3J8SaFLBgVY5HpgQPWSEQIqbXx_IHteF88hBT1rninNlJGWaQp9uZuhV7mdqxOSD7
    6JW-_1FErUZeQsVAik>
X-ME-Received: <xmr:3J8SaBtU57M-Qr4zyItSQejvUig7cMuoJS0fbo7vgnxaU9LK54m3HY60T04glQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfvfevhffutgfgsehtjeertddtvdej
    necuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnuggvvg
    hnrdhnvghtqeenucggtffrrghtthgvrhhnpeeiueejjedtgeeuhefggfejleekffduledu
    gfekgedutefgvdegtefhteetfeetheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhnsggp
    rhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfshhtvghsth
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhmohihvghrsehrvggu
    hhgrthdrtghomh
X-ME-Proxy: <xmx:3J8SaKZ91qYppn5WpZjajciB3_q2FrZPFZBKSMlJ9jjzftQNC978OQ>
    <xmx:3J8SaAZogsNqnkcVsjniPn_T_uELDkbbeRy6Eb4RnuQ5KwUGE8XYlA>
    <xmx:3J8SaOBKagINZUMbmKC3NmXVYGpoWjZDeUZy6N0p3A1AD7yteeXJ7Q>
    <xmx:3J8SaOaypD9tg5FEdInnJvZslkakGqiAP7AVf-vEAd_Ke2yqCkvldg>
    <xmx:3Z8SaNKSgnydBqiZvrhO9QJ9REosHMTksD5UpRFSV49POkFZONHPjn-j>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 18:10:36 -0400 (EDT)
Message-ID: <51ac35ec-1f3f-45d9-9cef-1ee424a9f9fe@sandeen.net>
Date: Wed, 30 Apr 2025 17:10:36 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Cc: Jeff Moyer <jmoyer@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Subject: [PATCH] generic/126: Do not run if TEST_DIR is sticky and
 fs.protected_regular enabled
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

generic/126 fails in somewhat mysterious ways when run on tmpfs on
systems that have the fs.protected_regular sysctl set > 0, because
tmpfs defaults to having the sticky bit set, and this causes
may_create_in_sticky to fail when the test tries to create writable
files.

To fix this, _notrun the test if TEST_DIR is sticky, and the protection
is enabled.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/generic/126 b/tests/generic/126
index 142d2bb9..007e4433 100755
--- a/tests/generic/126
+++ b/tests/generic/126
@@ -21,6 +21,13 @@ _cleanup()
 _require_test
 _require_chown
 
+# If the TEST_DIR has the sticky bit (like tmpfs) and this has restrictions,
+# skip this test, because fs.protected_regular changes expected behavior.
+PROT=n=$(sysctl -n fs.protected_regular 2>/dev/null)
+if [[ -k "$TEST_DIR" && "$PROT" -gt "0" ]]; then
+	_notrun "test dir has sticky bit and fs.protected_regular enabled"
+fi
+
 QA_FS_PERMS=$here/src/fs_perms
 
 cd $TEST_DIR
