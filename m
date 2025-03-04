Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B716F1FDE3A
	for <fstests@vger.kernel.org>; Tue,  4 Mar 2025 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090893; cv=none; b=KMhNd/GB8/vbK2QVI9h1Zo58qS33OjJ2+YAH5osTN8SUbHqQ4Kcs9B6ZJcPSnDu235cDuTduPMycAYEMsXin+c9C3OAfm6/KYH4elZEQfzu2nQhZmEOX0uyYorWaVlxQDEt/a4NtU1Fp1U/oAEQ7e7qU0is824hbquWzHZGJhe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090893; c=relaxed/simple;
	bh=J8sJY678tZZ3mBsIUGjvYAdzxCAvmbcaoqXldDDbMT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ag9l5ZwBIBnK20n6SOY0pXbPLpq7BMabDYvW0frAgOD9wjrSg5bMbsbQlGQynErG8cK4BSrEnw1apQa3BFbpAGqBj/YkwMWsJ0HF+acNkx7syEsRB8nxPIosaOMsPMj1RQvwUsAwpFGflMETCrsCsl5cRFjqJzGw1KU+T235/l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=bgGNQeSS; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bgGNQeSS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9BcOhNMk3ESzOPxh3/TI4t80RwKZNb3aL1HnFIpJG4w=; b=bgGNQeSSVCsdZqfrN/JeuGfurA
	cvpyIc/y8qmPyE/Ypb5wu76BdF0mCBIBqPP5TgHIqO20+F+wStNNsLlZYLMHSivjNEdx2TF1EXZVW
	Mnu/y5jNmK89ST2HnDAfa5rz0vYiwjp1RTxRP5iT58wJqWgo+RDD+3W+szQYJm+JSbDG9oz+eddbx
	tkC5X2OHO/+D83jI5q40j0MqTduuwUbbjIw9/uYE6exdtlIx5TXCwh5HlmRC5qIIck/95lMW0Br5F
	6H3ifyL0OARHFhjHXPZQL3iJnA2+klRkI3cAcXLSZ3WpKx7f+5w4wL1w8XL9jX+8xtV+jaSdhbBZz
	oUUo8gjw==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tpRGz-003hiR-QV; Tue, 04 Mar 2025 13:21:27 +0100
From: Luis Henriques <luis@igalia.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	Luis Henriques <luis@igalia.com>
Subject: [PATCH 2/2] src/locktest: add missing struct cast with syscall getsockname()
Date: Tue,  4 Mar 2025 12:21:19 +0000
Message-ID: <20250304122119.21412-3-luis@igalia.com>
In-Reply-To: <20250304122119.21412-1-luis@igalia.com>
References: <20250304122119.21412-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The usage of variable 'myAddr' (struct sockaddr_in) is being casted into a
'struct sockaddr' when used with bind() and with connect().  This patch
adds that cast when used with getsockname() as well, otherwise we'll get the
following error:

locktest.c: In function 'main':
locktest.c:1155:39: error: passing argument 2 of 'getsockname' from incompatible pointer type [-Wincompatible-pointer-types]
 1155 |                 if (getsockname(s_fd, &myAddr, &addr_len)) {
      |                                       ^~~~~~~
      |                                       |
      |                                       struct sockaddr_in *
In file included from /usr/include/fortify/sys/socket.h:23,
                 from locktest.c:19:
/usr/include/sys/socket.h:391:23: note: expected 'struct sockaddr * restrict' but argument is of type 'struct sockaddr_in *'
  391 | int getsockname (int, struct sockaddr *__restrict, socklen_t *__restrict);
      |                       ^

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 src/locktest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/locktest.c b/src/locktest.c
index 0e7c3008d1d0..a6cf3b1d5a99 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -1152,7 +1152,7 @@ main(int argc, char *argv[])
 	if (port == 0) {
 	        socklen_t addr_len = sizeof(myAddr);
 
-		if (getsockname(s_fd, &myAddr, &addr_len)) {
+		if (getsockname(s_fd, (struct sockaddr *)&myAddr, &addr_len)) {
 		    perror("getsockname");
 		    exit(1);
 		}
