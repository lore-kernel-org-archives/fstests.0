Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2973920A5E7
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254570; cv=none; b=dV6wo2XO5bfpZkbyKNdUYyKcJrIOlqw0AghmOo/b9HnmxqrdKKH0Zr5GuBFXNKoWhBjBP5+FsDa48vmkBVR1Kf5sb2NFy4fZYhLa7wLldXw7irdOwGrSOyRJco6X0YgJQcXvkNecVUM+TQiTQcxvckWjoNtCkZHf28rVqumWx98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254570; c=relaxed/simple;
	bh=+cx5lz/x1NkdsbeUNBxXgdCfYB4xcwBIurLylPtByrc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2/Ej31OJBXj0ytt02YsP9NFhhn83OAIzyVQ3bnl9ECP5TLuRJnMt893xMkApXbPxDgwN7ePHqjk9wH8GMuJ//3gb0Hyq8YyauOHUuNCBiQvfkrfN/zbTd2wUoMHWMGParz2Jts6DC+hbp0yga7c9UwREqnCqVSvdLhczhkYkrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6hB1au7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6hB1au7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC1AC4CEE4
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 09:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741254569;
	bh=+cx5lz/x1NkdsbeUNBxXgdCfYB4xcwBIurLylPtByrc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=i6hB1au757nrhDmGpvSc0aBtz1cElztBfZDObY3V8hse3tS5qjiLdNQ96Y1CGyhY2
	 fLfGICFpa6wdhxkYoYM9YPMvOsjND4bpnjxcS7jfH8WOP/seaHGifzQoi3xMf9dEnz
	 74N6m9K7xD2Pi0MADbdF9ZqkKw2h4AzTbeSEOlnJbuL6SlzGV1E+JKQuPacIZYFlJq
	 w+nA+N6L96O8f1UdfeBFcm+4dOfq8yfZxYfyH/VIN3EFrWt5y2dVebqjoBYJdZbvdQ
	 fIgQYYSTEARKx9VZha74aUSXyl6YidjUJBhLJLtFVG0jK/O5vAYSO10yWHxtthVyQW
	 BzG4RzLhq/m7w==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Subject: [PATCH v2 1/2] check: disable HAVE_PRIVATENS by default
Date: Thu,  6 Mar 2025 17:49:23 +0800
Message-ID: <20250306094924.1353269-2-zlang@kernel.org>
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

Currently we have 3 ways to run a test case in _run_seq():

  if [ -n "${HAVE_PRIVATENS}" ]; then
      ./tools/run_privatens "./$seq"
      ...
  elif [ -n "${HAVE_SYSTEMD_SCOPES}" ]; then
      systemd-run --quiet --unit "${unit}" --scope \
             ./tools/run_setsid "./$seq" &
      ...
  else
      ./tools/run_setsid "./$seq" &
      ...
  fi

The "privatens" way brings in some regressions. We need more time
to develop and test this way, it's not time let it to be the
first default choice, so isolate the HAVE_PRIVATENS initialization
by a TRY_PRIVATENS parameter, and disable it by default.

Set TRY_PRIVATENS=yes to give "privatens" a try, otherwise run in
old ways. This patch can be removed after "privatens" way is stable.

Signed-off-by: Zorro Lang <zlang@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 check | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/check b/check
index ea92b0d62..cb2f19d08 100755
--- a/check
+++ b/check
@@ -674,10 +674,13 @@ _stash_test_status() {
 	esac
 }
 
-# Can we run in a private pid/mount namespace?
-HAVE_PRIVATENS=
-./tools/run_privatens bash -c "exit 77"
-test $? -eq 77 && HAVE_PRIVATENS=yes
+# Don't try "privatens" by default, it's experimental for now.
+if [ "$TRY_PRIVATENS" = "yes" ];then
+	# Can we run in a private pid/mount namespace?
+	HAVE_PRIVATENS=
+	./tools/run_privatens bash -c "exit 77"
+	test $? -eq 77 && HAVE_PRIVATENS=yes
+fi
 
 # Can we run systemd scopes?
 HAVE_SYSTEMD_SCOPES=
-- 
2.47.1

