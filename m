Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F620227E98
	for <fstests@vger.kernel.org>; Thu, 20 Mar 2025 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742498897; cv=none; b=oxf8trRtegvwlVhz7OqPdCDimuKtUau0Neg/QkbhgwOGkG0dTt8lb5VvdV9BYkM3dqAjfAw8iOhDXqnEbNd+Hjdy75jtmslq2JDLGHcs5eKIOc00/qgAlHxwbzzheB4jUAe6UwoW3O4g55EoW3nhnrsIV82aV0RCZVht4HlYYC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742498897; c=relaxed/simple;
	bh=8MktiSKU2sRV4bgADvzOlPZfpGYVM6dm0Jq8vZHKlkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GVxkVi8TMdUzJduHhUIUVpBIDmHcwCCSOaGrqw+h8iv47NyhSqvlKaVwkU913iI1VpLuVQiMPYGHRXuqHJ1xkbacCgXmxQTpS6g9062VRd+IkHyyd1DoYkwJtQNKCZyWDERt4vOPokRR9yTP6sJPsyBtkRgBt4bdJ9OxzLDyV/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijfu+/FC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijfu+/FC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF04C4CEDD;
	Thu, 20 Mar 2025 19:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742498895;
	bh=8MktiSKU2sRV4bgADvzOlPZfpGYVM6dm0Jq8vZHKlkY=;
	h=From:To:Cc:Subject:Date:From;
	b=ijfu+/FC3Et+aTeaeDOEySg+WrUnJJ0c8yUxSpHqHpQTn3fkh2FzKKqUX8v8WXZ7N
	 JZdncPpeDGNpXrYCtdgT11U28ywgtDRXsuNDIE91YkgoOUpsO+MV8v7m2GwOKaPTJm
	 im63NpEd70qrid71KGhYIQ0SeWSN+L2Omi5f5TDdnksCW6MjzOO+olsfzd3k4/zSNG
	 MXBhZcuESQV7d8ygZKRhgpna7CyHP2HvaaUM6syx+L4F+AtD+jBkCjLOyb7iOyd0gg
	 EP7iLm+kM6c1n+UBfgbglomJ33kUMzfPHOoSTNmzlVRszyFyzAxnV4J2Z7z6aJ5mGA
	 /8LCfj+rM67YA==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH 0/2] revert "setsid" and "privatens" test ways from check
Date: Fri, 21 Mar 2025 03:28:10 +0800
Message-ID: <20250320192812.782380-1-zlang@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To isolate check-parallel from traditional check, let's revert "setsid" and
"privatens" test ways from check at first, due to "check" doesn't need them.
This also helps to avoid some regression issues or behavior changes.

The run_setsid and related things are removed totally, the privatens is removed
from check too, but the run_privatens script is retained for check-parallel.
Later, check-parallel will run in private name space way, won't affect the
check running.

More details refer to two patches. And please feel free to tell me if I miss
something.

Thanks,
Zorro
