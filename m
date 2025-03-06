Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF5120B210
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254572; cv=none; b=fxGYtuc0apB2OOF6CN8kZ9QjlLuXY8DH/u2T13dNR0CRUZhOGxArpNFuE2ysJMYct+9jwoWCRwNFGf0knhts+NGJVvu+lZblTU8MRpnn30oU7btkJan2fk+C6p8ZGU4pc9KJgVADMRjqWIujzOTclbgaBTypcbs1asSm5q3ml+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254572; c=relaxed/simple;
	bh=HvbIMpbC+TlPtJavlPg7HkmLjwR9jUTAFgAeaB2lHDQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tj1gGmllD2Y5m6ZcpVyNNJijkwIAxTZTGTSyx2EMcOps9dO9RkN/PWcbj9AmrVhIakXelL6xOzibvzMJXRkEuWuId+gr2ZKw9OzJh6cIja2p5AM8hh+xdujxDH7hQqqQjS6NJ6+V0Fnh3DX69xTde0q3mc96IRq1RqBBgpemR7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7QJ3e8E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7QJ3e8E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575AFC4CEE0
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 09:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741254571;
	bh=HvbIMpbC+TlPtJavlPg7HkmLjwR9jUTAFgAeaB2lHDQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=r7QJ3e8EUofn9dqA39tNzwcxZT7wxJZxIKpAQ2wTzq8eHxxK3EKYXnnT32CI6ezK+
	 HecdiHY6WWEHVrECe81j+JbFRdnF4nYPNHMd+fN54JO5K7ZbOG4jbOrTx+9J+5CNwK
	 llXWaczltHxmwtrZaxQyVndSP7IJnxH8w0/wdE2ZD3Mjsk/NK7w3eWGfxmOOjszhnb
	 9SshFMqNHcWfrx6e1bcuH8avgf6DQCe78iJHkA7XSDHqsvOcUlD13EZDc0m8i2Gh6P
	 1giecuC/OkEmzmJqAIhBP5+bsuAFd1gBYk2cm3RFWvDKGfqdxp4rWKClikSZcZJMt/
	 tzRuSkAwexDtw==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [PATCH v2 2/2] check: remove the deprecation of sessionid
Date: Thu,  6 Mar 2025 17:49:24 +0800
Message-ID: <20250306094924.1353269-3-zlang@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306094924.1353269-1-zlang@kernel.org>
References: <20250306094924.1353269-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As "privatens" way isn't recommended temporarily, it can't replace
"sessionid" way for now. So remove the deprecation.

Signed-off-by: Zorro Lang <zlang@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 check | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/check b/check
index cb2f19d08..33eb3e085 100755
--- a/check
+++ b/check
@@ -695,15 +695,6 @@ function _adjust_oom_score() {
 }
 _adjust_oom_score -500
 
-warn_deprecated_sessionid()
-{
-	if [ -z "$WARNED_DEPRECATED_SESSIONID" ]; then
-		echo "WARNING: Running fstests without private pid/mount namespace"
-		echo "support is deprecated and will be removed in February 2026."
-		WARNED_DEPRECATED_SESSIONID=1
-	fi
-}
-
 # ...and make the tests themselves somewhat more attractive to it, so that if
 # the system runs out of memory it'll be the test that gets killed and not the
 # test framework.  The test is run in a separate process without any of our
@@ -903,8 +894,6 @@ function run_section()
 	seqres="$check"
 	_check_test_fs
 
-	test -n "$HAVE_PRIVATENS" || warn_deprecated_sessionid
-
 	loop_status=()	# track rerun-on-failure state
 	local tc_status ix
 	local -a _list=( $list )
-- 
2.47.1

