Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A6B1FE44B
	for <fstests@vger.kernel.org>; Wed,  5 Feb 2025 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714996; cv=none; b=skrw0KohBX8jJ0NS1BeKOj1GYaZCiv9xXmb34Jj2g0eTM7ldHsaV5/JpsnfLhoCEJWZx67e9z7qaSvzGHbdna9GiVhTVSjqp3g6nA6kkLRe+zw+jtD46ZaLkamHJgcVmX6IRP2wFsvqUkUjqO8kLFZfJcmA5hTVfTrkFuDbfVJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714996; c=relaxed/simple;
	bh=Hd+Bd1DHfhuoAd8jCHrYUICiIaVX7i7Lf+yJMvTB/9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwe6yfMWUNeVokTYF+1sj4hXGrBl2MPpsgphWJdepOoqrwGAG+GsPTOW9gHnXXTN1qYzuR3Yp5bKRbWJbI6wvZYvDy2T05gns+Tc2S0QfiV4xmsfU7NxeZXrDHqkiFGt8aOAm3WBljPBsIXvCnu9JWY09O+4zhdonPtBXXHJfhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=C//uXJl1; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="C//uXJl1"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f9e037ee4cso371902a91.3
        for <fstests@vger.kernel.org>; Tue, 04 Feb 2025 16:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738714994; x=1739319794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z7eaW4TAv42Sk1OFl7oylyqSQ7nTUoHBIO8gZ5Ee1xU=;
        b=C//uXJl1bS6fblSIfz2BjznA+jYDHpTUPvJ3RhcEQfhbcqLRl/75ApL8gMD7U0tW3t
         fyKQa/Qu1KD0uV2Zx7007OwsGcK73zuUYOkFkBqdItZw1xe93Ah6pamUCaaCCAlcVnvE
         hZTbz7JaJ/hm3zdK3314b+l9AMcVo6B6Rp6WkCcczbhd1gregjQDpotXu1iu5pF/Fk37
         vBzuAwoXeptpfa4oSekUIuPBU1DQYM1T+oaZxX9M3hgw1qivNnd/6trIKorcOLQ9Cnn7
         10RxyU8jtKFxfnWXLC5GgTQaSk6HKzTF6oX/ZksXu7ZW5mcxiHbMN8doa+C/NHsPxiqS
         exxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738714994; x=1739319794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7eaW4TAv42Sk1OFl7oylyqSQ7nTUoHBIO8gZ5Ee1xU=;
        b=GuIFhDMjyIXQCwA8WOuKVY1+QAeN1hxd7tEkVA+WFKdDDZB8Q7qQwl+vxxG6TXjOUB
         4kz+Pa0ubHr70Jgns+MjIY+3y09IZ9ByRE2yx5Kpq41ofaJPCiD/ST3zqWL48UH7JYHG
         koIeWf6fbM1oDtw5uf/5CodIxHu0IBAnVTY5PmtETmEsF3B5tYZoSiDfuVDDgbGRi5B/
         r95Di4Rqa/U9duhnbchYQw5cQ49ijQ5WH8UsD7hioApOOzo35BW5iavLt991mO8uFw7U
         uqIxBWj9wIi6QTaB2VSOgpqqTenuwSdm51tVlCUmj6VPdH0XL/FF3BVt9VsMfQ1/+X9P
         jK1w==
X-Forwarded-Encrypted: i=1; AJvYcCUJQCse9C0FKJEnELryk9NzNOhkfqum0Ca7c/f7EUsF2Al6Rn+vVEl/dLB02lFgX7DrgfK5eYBf@vger.kernel.org
X-Gm-Message-State: AOJu0YxEAHfmLBeUSLhZ79e8rH3SEnIwJH2sjYPOwdmfjhDPzwqMZvBd
	83BtdLFz5lcIiXTVsVrIr+/nkVoHH9AaMA58bihnjU07AaJQ/zr5hHKFefYHiL8=
X-Gm-Gg: ASbGncvHjdqkvyO44hOSnnNRoVRdLH5v03Xd9U/hThjLjKIlzG0R+bTtQHO2t+k/Hvu
	TqEmrrlWTOxGTXIvMoa4BpFOAk6ut3dZES5fJ7+iwNLbDu/aNg80VsyU0X66hVIuex6BKQQdr3p
	vW1Yb5ZJ64GJiewrCHnOuy2UqEnfu3w4SsQAcPJp8VYywCGisqqVGm9+0zbRFYhMBmRM2vHBsqM
	X1INehT3UMeN0mGPn1S87QyPEZ/qtjnNEyyuc4NXXuzWIlGGD1kD3EWKkNliTKf1WlIMDZiWBif
	4L64nm9EYRrBAe+XEbSaHc0azX+10dvRIo3GZiv+PPXn+d5Tbe5jTxpG
X-Google-Smtp-Source: AGHT+IHvBVJTxmuWaZgneAt/xe+HWhF7851xGgQjFxlXhGgIpD2vqxTePbcyB3yrBJvlBGaQbi0j9A==
X-Received: by 2002:a17:90b:224e:b0:2ee:a583:e616 with SMTP id 98e67ed59e1d1-2f9e075f3afmr1303238a91.9.1738714993823;
        Tue, 04 Feb 2025 16:23:13 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1d8971dsm164850a91.22.2025.02.04.16.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:23:13 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfTCA-0000000EivK-1FiX;
	Wed, 05 Feb 2025 11:23:10 +1100
Date: Wed, 5 Feb 2025 11:23:10 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 14/34] common: fix pkill by running test program in a
 separate session
Message-ID: <Z6KvbgZnaIA1PTmv@dread.disaster.area>
References: <173870406063.546134.14070590745847431026.stgit@frogsfrogsfrogs>
 <173870406322.546134.11678961837706398324.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173870406322.546134.11678961837706398324.stgit@frogsfrogsfrogs>

On Tue, Feb 04, 2025 at 01:25:57PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Run each test program with a separate session id so that we can tell
> pkill to kill all processes of a given name, but only within our own
> session id.  This /should/ suffice to run multiple fstests on the same
> machine without one instance shooting down processes of another
> instance.

I thought you were going to drop this because pidns stuff available.
Also, because it is only check parallel that needs the pidns
isolation, and I'm not doing that external to check. Hence we can
just get rid of the 'pkill --parent' requirement because the
concurrent tests are already being run in isolated PID namespaces...

Regardless, if ppl still want to both pid session and pidns directly
into check, the code is fine.

Just one little nit:

> diff --git a/tools/run_seq_setsid b/tools/run_seq_setsid
> new file mode 100755
> index 00000000000000..5938f80e689255
> --- /dev/null
> +++ b/tools/run_seq_setsid
> @@ -0,0 +1,22 @@
> +#!/bin/bash
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Oracle.  All Rights Reserved.
> +#
> +# Try starting things in a new process session so that test processes have
> +# something with which to filter only their own subprocesses.
> +
> +if [ -n "${FSTESTS_ISOL}" ]; then
> +	# Allow the test to become a target of the oom killer
> +	oom_knob="/proc/self/oom_score_adj"
> +	test -w "${oom_knob}" && echo 250 > "${oom_knob}"
> +
> +	exec "$@"
> +fi
> +
> +if [ -z "$1" ] || [ "$1" = "--help" ]; then
> +	echo "Usage: $0 command [args...]"
> +	exit 1
> +fi
> +
> +FSTESTS_ISOL=setsid exec setsid "$0" "$@"

The wrapper should be called 'run_setsid' because what check is
using it for has nothing to do with what the script actually does.

With that change:

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
