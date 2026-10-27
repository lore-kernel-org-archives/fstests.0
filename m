Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109119;
	b=QvGpx5CkqIz5QagXg9wiWrwN+yzTyVWHoTpmKC+loFaHYd4iio6qiydT0lLIzlfRJjIY
	 GOavia6gbZdmG9Wml6oSFfDt10Bal72xsF7Oowh46l9Rdt+2VGqlFLTsmqGVeLNtPckLg
	 PdqQsna4xc43Jd8y2IyI2jC+oGMjkKvgQlmmf+TJ4EVWxAELmBdjPdj17RwmGzcjHAUzM
	 mlirKLwEBB9gEnasXiIjEJEL2KluDYFZHnuUbL+BZ2Ncd+aSjg+z0SCtOH18zsbmg0PET
	 c276DV0s5Ra+6rQwk91tkE8NYnUldJOARa6S6LnMt0otM7xvLbIW2e19m6q/VIl08Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109119;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=N+p0XoSmr2H13f5vwBkowgUYU58PnwEBlMNcVr3hEf4=;
	b=1Utt2V8kmhIEdtXXcbHf36lWDNWO0/tK/Nwu/wP2gtHRcVYq4kkr48i7KfkXhuMh04uA
	 LQzqEG+gJn60MU2WZCEcFvVODyMdXE4H1tIcnRsegtempvcaKt9s30Yc668Em4DQFxk0Z
	 SFi60uNhXGH/WXDTB+v/nJr+bfupw00iqjkPBSV+RujYC/vKIeggljk9sBpyjAT92/zVl
	 r2rWPDgyCGvdCViKlNeH1f1SDLcpQTR8jNfBhU3oUptONNWM1IkVNPCzCmmKODaoF89TA
	 e5fEhF78fXtt6JgKZFNpNs/Jb/IDGp8yTHAbMEd7bXKHCaIDT23ZG7rRznuiIYISrsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ly5Z1HRz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701A5606A31B
	for <fstests@vger.kernel.org>; Tue, 27 Oct 2026 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ly5Z1HRz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF79F1F01825;
	Tue, 27 Oct 2026 13:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793109119;
	bh=N+p0XoSmr2H13f5vwBkowgUYU58PnwEBlMNcVr3hEf4=;
	h=From:Date:Subject:To:Cc;
	b=ly5Z1HRzq8uqoeIk49BLT8UDpGChs2gACt6Oz70/jpJNnW64KFN5H/lbhyosNcl/v
	 2gR5O5wXuKrLGulU0Y6/4LPpkPfdZLnl4R9+F4OM28AiQDsKPvFVn5j0nbTwIPNvgK
	 JUeAnXL1CSjmyUUt23osuWOgQAEeSF9AdtQ55Uqh97CrJ/EjwBiI8bgkc0qqTebJtb
	 W2c/0sr7NL8fZYP1+Qn4h4zK+i0Ayb2TeU6nU7xxKxiiIRheVKU91X2lLqtyuDWckb
	 /uSt2Or9L/sA9iP9llCqa6gZtlqbs43IQsDdn173OEgGh+BJCd4I31DWr9CU5Yld3o
	 cKU0vRuVzVmSA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 27 Oct 2026 09:51:54 -0400
Subject: [PATCH] tools/get_maintainer.pl: accept and ignore
 --nogit-chief-penguins
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-b4-v1-1-a87dca9172c9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNz3SQTXdO0NHNT0zQTc0OzZCWgwoKi1LTMCrAh0bG1tQAoOtwNVAA
 AAA==
X-Change-ID: 20261027-b4-5ff755f4716c
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1236; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=WTtC8kqjvD1fH5lzZ4oLoiZhA43tTgcUSubeUT+SI10=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBq4Kx+qH7rQmdwYBQRqZR0tBeOutSCtt1c22JQc
 JOXVlpFjXKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCauCsfgAKCRAADmhBGVaC
 FXffD/90qI4zxrM0komrkVnrzVhUjlXHA5OdcNRtAwWWwElySpaq5mtT4TYap+3XF9IQr5r40t7
 oOYipU9eilLarcvhWeGA6KPqiFj7L9M/UOa5ISh6w0fhZmSI4NoiMp9zUfi88hXoxcsBigI12+L
 2+EbdRmGf6jnmVOBw3NiKxQdoT3gG3DwmbHkB3zRBY9aLb5bRGFbbK3eTWn77QbcXTf155DGgff
 VTQCZxofnoYVIp6x4YNEacjeKME1LJmG9E4XyKOEJYxsTwX9eDgZdwKvSOQlvoQZZF8dqfEBkB1
 iMbrD5/6UpxtqYzTeykkuX1cedIdtqUtOokipszrw6g8x0hGkxVdbcSSdeLCu0IglXB839RKdXv
 h8XtCZhSZtOk6v98Y1jufeklPGO2tvpvzavzqLl/KJBQB94yRlcnYDZSqiuKG/aM4jHAhcvLnjv
 EwbnA8aDTXfxmEjTXF49frWexZTZH9Aqo5SJODZV4C4p8mEfoBu8TIzQiwllrQYdwWRI0MJRcjG
 GWfiIxsDrJq1xN+wpBVHVJ0KNONL0AxMxrN9S8kCYyJlx+UQJz2RqmK/MHDJDM0pkqBVJC/4bBF
 TuB2UULXRR+oikvPBN6U+g3n5q+fnYHpGBeO/xqPrbm53Hm9fIl/v0X9nsVMH/snA10mTlVGg1U
 T/rXc0jyxQAvyLA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

b4 prep --auto-to-cc passes --nogit-chief-penguins as an option to
get_maintainer.pl. Ensure that it accepts and ignores it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 tools/get_maintainer.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/get_maintainer.pl b/tools/get_maintainer.pl
index 671ffe26a799..02c02eea3e67 100755
--- a/tools/get_maintainer.pl
+++ b/tools/get_maintainer.pl
@@ -31,6 +31,7 @@ my $email_fixes = 1;
 my $email_list = 1;
 my $email_moderated_list = 1;
 my $email_subscriber_list = 0;
+my $email_git_penguin_chiefs = 0;
 my $email_git = 0;
 my $email_git_all_signature_types = 0;
 my $email_git_blame = 0;
@@ -228,6 +229,7 @@ if (!GetOptions(
 		'git-blame!' => \$email_git_blame,
 		'git-blame-signatures!' => \$email_git_blame_signatures,
 		'git-fallback!' => \$email_git_fallback,
+		'git-chief-penguins!' => \$email_git_penguin_chiefs,
 		'git-min-signatures=i' => \$email_git_min_signatures,
 		'git-max-maintainers=i' => \$email_git_max_maintainers,
 		'git-min-percent=i' => \$email_git_min_percent,

---
base-commit: 22348afe338c0f6d540c0d7ef0db749eaa51b218
change-id: 20261027-b4-5ff755f4716c

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

