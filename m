Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165671DC9B4
	for <fstests@vger.kernel.org>; Tue, 18 Mar 2025 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742330377; cv=none; b=XYsMg2foN5/P9D+ThpPt2tLomKkKkJwgt6O7F4JnLd5nipZu3UYqyE2cv4gJZXU1wO6Uyg4P11TkCoyH5iPQSoHR4t/5/G1svwNq23nrYUOKyGcN+SNtJJDb7Fbd8x+XJJ2fmzt4aVOap/Tm7YThlW8EAlHTcUBSYXOIgOPf/fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742330377; c=relaxed/simple;
	bh=VrrhmvEEheWVHNjVCdFALfBevYvTLzRFLBRuM15rzBs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=MEagijlXOLvHggr2glX3wsigIekHd+n07Oxgzz3WslDJ6RXIIOqH3IMSr+UdBVysd91BogUTwbmAl+kLJ71nMrPTKiVG9DouWA1A3ru8evU7zDH3Py43UaIdan905rUhwLjrHj+u/3IiBIyJAIBWzbDU9+2mkP1CMdqvAQG0v2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=bFQnu8B/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FcJUco4U; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="bFQnu8B/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FcJUco4U"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1251225401F9
	for <fstests@vger.kernel.org>; Tue, 18 Mar 2025 16:39:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 18 Mar 2025 16:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1742330373; x=1742416773; bh=VrrhmvEEhe
	WVHNjVCdFALfBevYvTLzRFLBRuM15rzBs=; b=bFQnu8B/trqYcM9c2fE+cppjGl
	SBb75ckcv1YJ8RifPu0V3U/82vV8U5/iiEAa6g72fbkPrqrAu+SJr+nm8l2SpNKY
	y7iIpeNC3XTqALUjq2dNzjKlCUzZGV4ubh5gmxEjp5J0UD2OjrwZ1Igss7U+ZA+U
	SclUcvHMv0omOdXOBpxA+gy8RCVqig1e3LIGzfbFCpVRuJFsie1mkHwvDyeqHVu7
	hloZDn4vHr8efTGEiZgoKtguj7ukN5iQr/yk/KXw/D5C3JDJs2XvZFQvxvcZfkwJ
	HYQv9zPRHEL0WJjB0qNKnqnKuO52/HwJpMcWHQ2LxDqulbfz7EnpCqQsHBRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742330373; x=1742416773; bh=VrrhmvEEheWVHNjVCdFALfBevYvTLzRFLBR
	uM15rzBs=; b=FcJUco4Ui0TxbZLeJlssGdNLkSPl/MQ49Jd3Wl/+WQlOiI/Wb2A
	feDJ00xAajGPWMEj2hKAS+R6EdMC5FUKU2Xss7CoSUlBqeeiFv9i3LZd+H+NjIsz
	hpUx13fJzMkaidPQKhlQ2x+LVXnD9esUlJMBLzNFhO6nGAO7vMhuIL0RgkUabB+n
	nYGn/0NJihU8qiQsU5EyKJZoNqUpELr86hSKMYAISBfelds6sXaiv/yTAneWJGuK
	zJ+wRBl7NdasTVxuiYbs3RyWurxr8mRq4IFj8dpSYuXwq66Zl98Cycrmi1FlpB2p
	yDv25xGUtWBpSFSb27Opov8rYHKnabyB+ag==
X-ME-Sender: <xms:BdrZZ8pSFRB6PFJDFhk2Cm66XYTeJGDz7L0EXo3HuhP0p1BoEFxszA>
    <xme:BdrZZyrYo8dRQroOyvTVTeDyO939YaJWwxybkNPgrzL8YdDqPOjf-Kiz4z2M2vB9t
    3JCZIGVILwNx-Pd7n8>
X-ME-Received: <xmr:BdrZZxMeEd8JvSv_PXWEZq-3LdI90YwpGyHinnvpzp_SySEKPuDdxwoU1xpkAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeefgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefkff
    ggfgfvhffutgfgsehtjeertddtvdejnecuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcu
    oehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtqeenucggtffrrghtthgvrhhnpeejff
    efvdejgeefleffieekuedtveejheduieduffeuledtvdetfeevvdeukefhvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghnuggvvghnse
    hsrghnuggvvghnrdhnvghtpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehfshhtvghsthhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BdrZZz5MttOu2aPPfyU_C6YPw2h8iZFTuXp8bhOjesVvshFinX-jSA>
    <xmx:BdrZZ77uiTYBD8oNW5-4H-H7VFZzqJqyJnJXjmDztu-QXdj26Huu0g>
    <xmx:BdrZZzj3R4HWbGKTg8iQNlB76jicOt5-qoSfxobbqAiadxNgRC6h2Q>
    <xmx:BdrZZ14k_p2hN2Yyiu6krvRAO-4tg9YQNzfs8PEm8sLitHBLsMHeZw>
    <xmx:BdrZZ1RhJybu0OX_L1313ScdHw95-BXlDb2IaGDoObn8QUZyDUrct4fx>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <fstests@vger.kernel.org>; Tue, 18 Mar 2025 16:39:33 -0400 (EDT)
Message-ID: <c46d8caf-053a-4af1-b562-7ca7203cb926@sandeen.net>
Date: Tue, 18 Mar 2025 15:39:33 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
From: Eric Sandeen <sandeen@sandeen.net>
Subject: generic/699 fails on ext4 due to using ext4 mount options w/
 overlayfs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

generic/699 fails because _overlay_mount_dirs() uses _common_dev_mount_options(),
and when FSTYP is ext4, that yields "-o acl,user_xattr" and acl is not a valid
option for overlayfs.

Lots of overlayfs/ tests use _overlay_mount_dirs of course, but they run with
./check -overlay which sets FSTYP to overlay, not the underlying type.

I'm ... not sure how this should be fixed. I have a hack to temporarily
override FSTYP for the test, but that seems bad.

Thoughts?

Thanks,
-Eric
