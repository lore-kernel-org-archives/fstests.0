Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403722;
	b=VaEZ8uP+nYukX9ojt6B75N3cmcqDe4o/BDr2H/92rUwI7Cm9TK9eKqSFrjG+ORemEgzQ
	 AmiWw4XW2g7D16v5jtXTryetjh5NDgz9ZtTJswl9bDp5BzRENQFuyxpxHWcB5Gk/bLfGE
	 fnsSNbJr+rwq/OirPE1X9ALRTr4nekXWAp1QctfKMyWXYwZ+liKlX/U56CGQQrto21jco
	 4w7ZonlCwuaq+Yxh2xT1xsnqOVoAKqH0d556UkQATEcaaH/TOaSYvsY9ZpC6q6pdwI8ro
	 Un0+GhEEXZj7GR4yyJfANQt+FSHtsMkUZWnBt6k/MKy7DlFau9vB0HgNJfNrlRgxTzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403722;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+/o+g61vaFegzVsLtj4YwqLJLRI7ypxW+c1qDcn/T7A=;
	b=yr2QOz2f7MS2GtDdkQvU59KSB+rr1rNY+7sAKCjJt+0/Ab/tngz/IE4L1ZN1LRtQ+ptb
	 lpxmR7VHS9vvNbYt/lOI6x1ba2uD1jrzOJ90Ujol9YYLWdS1kV/pHha9VJDG2vJkT8DmT
	 6go2NyZEE7Kgm/ITu8CwwJWItJ2W/K45XEI4sbgomvK85HD9GU6/DOMjC2C4o0Um/tsys
	 8iTuP4Un2BW/c/NkfwXfDUFEhHq1OnqO9YGkl+d6egwmCiDefuTE6Qpf0Z/G4yoKjjZS+
	 u6EAORw0eYdrlbBLKp5kZHKjwo7sP1EU6g7ClTBS+Lh+7NvaXBJw5ONEbyBIQ3AkKeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=scrivano.org;
	spf=pass smtp.mailfrom=scrivano.org;
	dkim=pass header.d=scrivano.org header.i=@scrivano.org header.a=rsa-sha256 header.s=fm3 header.b=RyxlCerW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XupwWB9W;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C7606A31C
	for <fstests@vger.kernel.org>; Wed, 11 Nov 2026 13:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D84C7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scrivano.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scrivano.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=scrivano.org header.i=@scrivano.org header.a=rsa-sha256 header.s=fm3 header.b=RyxlCerW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XupwWB9W
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D47281D00249
	for <fstests@vger.kernel.org>; Wed, 11 Nov 2026 08:28:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 11 Nov 2026 08:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scrivano.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1794403720; x=1794490120; bh=+/o+g61vaFegzVsLtj4Yw
	qLJLRI7ypxW+c1qDcn/T7A=; b=RyxlCerWnsR6wdUpjpHVmam/L/GbkcHXdrjSl
	kxAWZAfPLK0VuNU+YXC+pP5iiNZden71aoj81bIBi4/nVyTygDrBQzmAb17bmMgN
	HxR3qMpB9p1tIfNrcSdBIZgw9kOWvPrEwyb8ZT6QLRmjfLQwxmqT+kAYdwEiF7R0
	dzujcp877d1cyEhdJUFH5QqHHz7Yb0QW5nxi07Ad4+qx8u2MLbFzecoiLGOzgp9H
	qv5e5IZFmGZ6kx8+tBeMprrSPzKbOAkDVEFbaoXIWHsES8CPCZ7zQQRG0N56JdqA
	4n5eD57+HapkLCrEqzosjWxDOaG11sPFQpRFuUE8EQLGrwO4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794403720; x=1794490120; bh=+/o+g61vaFegzVsLtj4YwqLJLRI7ypxW+c1
	qDcn/T7A=; b=XupwWB9WDRXloeJHyqQhmikz3YWWzuOXU+foLEGUiUAzLWeZQE/
	/MQuGd9lW5aQa9SaGNmZk7A5Sq2TfBxASjSHwIQPISJpA4EbL8iA/zLcX+3LJkHW
	kiIIeWFI4/B2Ad9hdZ4Mg3rFKrdoVf5KM1wP2Jdg72UxXs2gV7Zd5ZrtGyfXPES4
	ke0+PWb/X+5CQ2qplfUr3bmLP2gt7m3efBHV9g6bz1X4hfHMZBxcfpC0H3BQfdZF
	aewLUsW37U1OIwCQEa7OFHWIT+TTBzXW6cmmi+4RilUm8bJLpw/o9qnfuPrXUrqs
	ZcVhyXQN6cBkag73/K5t07MJ4YwYi8c/QHg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=scrivano.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794403720; d=scrivano.org;
	mf=PGdpdXNlcHBlQHNjcml2YW5vLm9yZz4=;
	rt=PGZzdGVzdHNAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:qHt3DOIflZyX9jyH5UTTgMP2cxSDQfYRgb9aU4Rb6z1t+/2
	+QOwhE4I2rv8lJOk9KljUkV9H9wdxTKk7s4BQLgzW/aT+hs2RjxyHMoJd5j576DO
	bD8rXUJkYR5xa2eOvu7eiWkGMAOq10Ldpdi0Bn2qY95GRHKHCTVtzrzSOOpEI0l1
	rK4UPdLQN7Zcrq4msrwZlMtzifSuARaalotw8ZjRqUfU1VRp2aw/3yN9DaVIeCnk
	zpmSmpLj773arK5DhnextcYY7KfR8h30eE/94D7gSoCEndyt3VqsMAwTkZJDwMtG
	7OdUwrWtQN0xBzBBtWkZ25DzpmWxzvU94anloNA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:q40+mjE/5qnub1t2mNQN50IP8XXy7WViO1i/CZvlDjQ=:j1kbThHFObjQwqEpf07HmItuHQoJIJDtgw6FC4B9ga0=;
X-ME-Sender: <xms:iG30apct4TzXAdNKpyMfngcgdRVhrxFkpsnHXEfIgAAgrEMXIuOWSw>
    <xme:iG30alAhKg314drkl34WiUWUp_OVdRi6qC3fCm2LqwRyxfOgT-E5oD90wiroYnMLO
    ma5jrlbt0tn5v7jnH13ehCKsJg8w7haVg-pQkPeMEgp_lPZAOUj6vQ->
X-ME-Received: <xmr:iG30as9E3zeDTWnBxEs7YjmIBLLSsdBLhWzUGdi1GeRrpsgTAvXVobYGNOeOOT4QT7WicRWzduOkw_hA6NuPbXeFT4vU>
X-ME-Proxy-Cause: dmFkZTGz+5AupcYWvxinBqbv22l5zBvFlNHo5Exw0kZ33axos7DVMeLH6czgPFj7Gsc8M+
    uX8gjm3TqAw5c+oxKA3K+BHNBERn45afVJqODeQd7Su/kPbI74ST7CpCQNBZ45UQcTHjFX
    fJgDRJ82Yus/R19dY9P5PQZ5iktLi2pG4G8lAh2cB1ZB0h+yCKFCPLGQWQOfd5Z92SbCXJ
    tEXcHoljytKkM1/puOBizapRDOV59LHscAPyM4Pn+3uAN/QXXU5hDqFRaAKKqfhczKV45j
    Ei6NCjeoNcznleMAfFUl81WY71lz7A1WQnaUX5av0+Nrnx7T87ii+J9N0yBwW4o9EYGjIv
    OtnkfGmWeayBI2gR/2sAfNOEZbvblqTVDxBomt5S7hQ6RO1prYjWONktDFh8PAJEHwH/LH
    ke58xLRgzU/fk7XmlCTgWXm2uGbHXgtoqk8VoExfXR3JaXIL/3lB8YBxe/Ic/cYtpDR/VN
    sNh5VyoleAh/pycsJtWIaskluQFwJArgIWDEeojjcgwHN3r/P4wMzzTqxIQ26qlAXlK+lj
    mRGoFOT0ifXw0QQWTVjoS2HXnwBufVFDjKlxWmeCn6G57rFPmi37ME5k8u0kwVrEh556Qz
    US+IbJZ37MyXg78F1crhIZr5Eqf+Rf+IBo3DFaenTgSxJ+I1PHsNsdQXAqOg
X-ME-Proxy: <xmx:iG30agKUTKFZSYk4soSa48dxy9oUZAS_M3mrdkPrWu_3QNSaKQd93w>
    <xmx:iG30aljkVzB0EqC9h0fbMBHFz_YO1CpasgFE1MVEW4y78f3ds_4MGw>
    <xmx:iG30ag4w4Hjx4CZqDq-spZzsp7ZtZWk1azw9DsEld8a19gN0COPhGg>
    <xmx:iG30atacm_aJBCTww1ucog2VaIjDR6RFt_GU5qMMkcxlq7L4B-87cQ>
    <xmx:iG30auWD0C0bUvWKuM7jNI8MjGSWrH1EKrfAsEvNMR4aEJ82X9evqKx->
Feedback-ID: i8e6e4897:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 08:28:39 -0500 (EST)
From: Giuseppe Scrivano <giuseppe@scrivano.org>
To: fstests@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org,
	amir73il@gmail.com
Subject: [PATCH fstests] overlay: accept EIO for metacopy files with missing lazy data
Date: Wed, 11 Nov 2026 14:28:26 +0100
Message-ID: <20261111132836.3495981-1-giuseppe@scrivano.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since "ovl: return EIO if the lowerdata is missing", open() fails with
EIO instead of ENOENT.  Accept both in check_no_file_contents(), so the
tests pass on old and new kernels.

Signed-off-by: Giuseppe Scrivano <giuseppe@scrivano.org>
---
 tests/overlay/079 | 6 ++++--
 tests/overlay/085 | 6 ++++--
 tests/overlay/088 | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/tests/overlay/079 b/tests/overlay/079
index cfcafcee..4ea4f609 100755
--- a/tests/overlay/079
+++ b/tests/overlay/079
@@ -119,9 +119,11 @@ check_no_file_contents()
 
 	target_f=`echo $target | _filter_scratch`
 	out_f=`cat $target 2>&1 | _filter_scratch`
-	msg="cat: $target_f: No such file or directory"
 
-	[ "$out_f" == "$msg" ] && return
+	# The data is missing: older kernels fail with ENOENT, newer ones
+	# with EIO
+	[ "$out_f" == "cat: $target_f: Input/output error" ] && return
+	[ "$out_f" == "cat: $target_f: No such file or directory" ] && return
 
 	echo "$target_f unexpectedly has content"
 }
diff --git a/tests/overlay/085 b/tests/overlay/085
index 046d01d1..b644e7ef 100755
--- a/tests/overlay/085
+++ b/tests/overlay/085
@@ -120,9 +120,11 @@ check_no_file_contents()
 
 	target_f=`echo $target | _filter_scratch`
 	out_f=`cat $target 2>&1 | _filter_scratch`
-	msg="cat: $target_f: No such file or directory"
 
-	[ "$out_f" == "$msg" ] && return
+	# The data is missing: older kernels fail with ENOENT, newer ones
+	# with EIO
+	[ "$out_f" == "cat: $target_f: Input/output error" ] && return
+	[ "$out_f" == "cat: $target_f: No such file or directory" ] && return
 
 	echo "$target_f unexpectedly has content"
 }
diff --git a/tests/overlay/088 b/tests/overlay/088
index 33215cbd..27011469 100755
--- a/tests/overlay/088
+++ b/tests/overlay/088
@@ -95,9 +95,11 @@ check_no_file_contents()
 
 	target_f=`echo $target | _filter_scratch`
 	out_f=`cat $target 2>&1 | _filter_scratch`
-	msg="cat: $target_f: No such file or directory"
 
-	[ "$out_f" == "$msg" ] && return
+	# The data is missing: older kernels fail with ENOENT, newer ones
+	# with EIO
+	[ "$out_f" == "cat: $target_f: Input/output error" ] && return
+	[ "$out_f" == "cat: $target_f: No such file or directory" ] && return
 
 	echo "$target_f unexpectedly has content"
 }
-- 
2.56.0

