Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9781BC41
	for <fstests@vger.kernel.org>; Wed, 17 Dec 2025 00:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765930551; cv=none; b=HxMJxH+hu3ii6YNY+xA6xUA3SLvjLBZklXIHXkpg6yUDjG6zImG7siexJ5o0mrK1tnhwCn7sxWKK2x7ObCwhwkGwSg8Pi1kmYnF5ZGNBuiAyRyUkAIxiun0Ut+B4kFt/hTriIq6C7wHDjCaVhvbpVw2eUDrFyNzeye5zY8Wdf8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765930551; c=relaxed/simple;
	bh=V7N+cHSmzX+IBcFdOnXxIlZbAFcQrimFbfbrpPXdMs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTJ/wK0ORl0MTx/+pH87Zg9cIc8Y2i2kYyWWfk/a5IKtQOJA2e0T2DZMRVX1TdR+B49vwCAIK8pUm60ykszwu5/vhyF9O8zQRQoq6K1pAfR35AKyVr9EktWYpy1tyciGK3wSgnxx2GDPzUHfVf111nV+pgQkwsCQQ6CSbmbN5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISt0OzRO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISt0OzRO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01E6C113D0;
	Wed, 17 Dec 2025 00:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765930551;
	bh=V7N+cHSmzX+IBcFdOnXxIlZbAFcQrimFbfbrpPXdMs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISt0OzROTaJLBPQLmsRyLxXrRug5sj5R4YHPtzqTcOpXgz0GMvDDL0345blpXLzkr
	 uRVnfSXw/gEwS2mmWughDvBAhKNf/CRk7hl0IWjvNSEi32xztmekAMcvOLO5yyXYmP
	 JkqLw5zpYuPEA6E/0JQpkiH2HSYldrNw9HjoDEGTkdhJcFTnTc0is0ITzqNg1DIBuz
	 mi7eeYPAleImYGtuPr3kNR+7lg2NWz0GFOIpSvXPhbXemnCBiOvMZ3sQbRq5IimCjK
	 UdcDt1xYoc1A4k9qN/IRBO+OsCXadI48/zJrhnEzJ7EpVxc+j8Xmq7u3i6D5yN7Zkm
	 k50z74McqsLcw==
Date: Tue, 16 Dec 2025 16:15:50 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luca Di Maio <luca.dimaio1@gmail.com>
Cc: fstests@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH v4] xfs: test reproducible builds
Message-ID: <20251217001550.GI7716@frogsfrogsfrogs>
References: <20251216080233.2324849-1-luca.dimaio1@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216080233.2324849-1-luca.dimaio1@gmail.com>

On Tue, Dec 16, 2025 at 09:02:33AM +0100, Luca Di Maio wrote:
> With the addition of the `-p` populate option, SOURCE_DATE_EPOCH and
> DETERMINISTIC_SEED support, it is possible to create fully reproducible
> pre-populated filesystems. We should test them here.
> 
> v1 -> v2:
> - Changed test group from parent to mkfs
> - Fixed PROTO_DIR to point to a new dir
> - Populate PROTO_DIR with relevant file types
> - Move from md5sum to sha256sum
> v2 -> v3
> - Properly check if mkfs.xfs supports SOURCE_DATE_EPOCH and
>   DETERMINISTIC_SEED
> - use fsstress program to generate the PROTO_DIR content
> - simplify test output
> v3 -> v4
> - Add _cleanup function
> 
> Signed-off-by: Luca Di Maio <luca.dimaio1@gmail.com>
> ---
>  tests/xfs/841     | 171 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/841.out |   3 +
>  2 files changed, 174 insertions(+)
>  create mode 100755 tests/xfs/841
>  create mode 100644 tests/xfs/841.out
> 
> diff --git a/tests/xfs/841 b/tests/xfs/841
> new file mode 100755
> index 00000000..a75f5879
> --- /dev/null
> +++ b/tests/xfs/841
> @@ -0,0 +1,171 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chainguard, Inc. All Rights Reserved.
> +#
> +# FS QA Test No. 841
> +#
> +# Test that XFS filesystems created with reproducibility options produce
> +# identical images across multiple runs. This verifies that the combination
> +# of SOURCE_DATE_EPOCH, DETERMINISTIC_SEED, and -m uuid= options result in
> +# bit-for-bit reproducible filesystem images.
> +
> +. ./common/preamble
> +_begin_fstest auto quick mkfs
> +
> +# Image file settings
> +IMG_SIZE="512M"
> +IMG_FILE="$TEST_DIR/xfs_reproducible_test.img"
> +PROTO_DIR="$TEST_DIR/proto"
> +
> +# Fixed values for reproducibility
> +FIXED_UUID="12345678-1234-1234-1234-123456789abc"
> +FIXED_EPOCH="1234567890"
> +
> +_cleanup() {
> +	rm -r -f "$PROTO_DIR" "$IMG_FILE"
> +}

The start of this function needs to copy the code from the _cleanup
function in common/preable, as Dave said elsewhere.  Otherwise this
looks ok to me.

--D
