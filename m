Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B722C202976
	for <fstests@vger.kernel.org>; Tue,  4 Mar 2025 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090892; cv=none; b=uY4sdzAf2tPpv2/9BJ5/HAsQwcofFX82HN89Wttmr6ahD91yvC2cWFz+ottneSoKZudyN+ARwTn5F6PrjnRzH6jTiuD3E4uvA7hwmxmklMKgY/+CVSiehCWM47Zxf4Xo1mnj04zccwKkQEQvC6fKHc6AggOp8zxFwm3QUfN5IX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090892; c=relaxed/simple;
	bh=MLMJvhinXsR4pqQz/Oc5ZV76O/1EjAsiB1dv3Geu/7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jF10KqYzeAj4A4lIQhm5l3MLUuqeMBXYp5lYbySrbV+QFxDs8u1wjbRWGHx3NBKeInqomBzPk3mZ36w5BCdS4oZI6B3yz0tRhuKvIrVecEKktftuFb6R6KoQcRGMdJXFGY+EfmFUiUemuxBErlcTXt6gp0SU6heQunEbO8PW7J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gf+LzNzC; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gf+LzNzC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HXHnYbfwbdGQg/hY73RCopCDxcJemmwPfTfmj63Mxlk=; b=gf+LzNzCJ6P+o29qjy3CygwsX6
	K3lnX1Gt+fjrhRFDBpbgWugdgbZHvjsE4lhz4tnkzCeFc6fG0hb4PPUXp65XhkOSQyBRCOGhTJM9J
	vdkZXK1DYxJ8mb2tfr3uYQpYC1KohLkjDVtBBZv2hhBTx4AecoD4wfmh7NEI2DQghsyDbp23c7wbP
	CdyvofGsRZECj8rNR0kvZ4XcdRlX/0ltmYsZiugkL0S2CHU5u66C63u+Za5J4Q221Fhuu/Ud5LJzW
	LoPs9n5J8gsRRNTQEaxL6Gokit+DAnsKGLeCjVnpIHECaX8ueMQnC4M1iBk2GnQ23Mp6r8iUtoeUX
	oVqj8Iog==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tpRGz-003hiJ-Bo; Tue, 04 Mar 2025 13:21:27 +0100
From: Luis Henriques <luis@igalia.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	Luis Henriques <luis@igalia.com>
Subject: [PATCH 0/2] Fix compilation errors when not using GNU libc
Date: Tue,  4 Mar 2025 12:21:17 +0000
Message-ID: <20250304122119.21412-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

Following this patch I'm sending 2 simple patches that fix build failures
when trying to compile fstests in a system that does not have GNU libc.

Luis Henriques (2):
  src: include libgen.h for function basename() if not using GNU libc
  src/locktest: add missing struct cast with syscall getsockname()

 src/aio-dio-regress/aio-dio-append-write-read-race.c | 3 +++
 src/locktest.c                                       | 2 +-
 src/splice-test.c                                    | 3 +++
 src/t_ext4_dax_inline_corruption.c                   | 3 +++
 src/t_ext4_dax_journal_corruption.c                  | 3 +++
 src/t_mmap_collision.c                               | 3 +++
 src/t_mmap_dio.c                                     | 3 +++
 7 files changed, 19 insertions(+), 1 deletion(-)

