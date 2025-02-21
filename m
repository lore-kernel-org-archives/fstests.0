Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D84C1FBC92
	for <fstests@vger.kernel.org>; Fri, 21 Feb 2025 05:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740114857; cv=none; b=s91gOYf2eopx5XOn644oFsJplbz7GKii7LVasf7FzsQFSX5M3cbEnMyHf+yw7NfQ+HwB+8VwgjWZkTjH0UDuMlw8R0Ra2cw+WgP8tKXKgLSItHD6e8sJFFqh81NPGrgGd/Yjbd5VerIkTe5X6Ttm9JBWp2tss+6f9XdsNAmdk7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740114857; c=relaxed/simple;
	bh=hTcL6xVksI+i8y2eM7T1Q3HZIbhcCkWtmmvqSTTg+bI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=kaoSBzQYnqWJFVwKbk/zWg8DQmiX8Z8FZKWvtLN2BJf0N6uzDWxWybGUqqY4rhImmzBRsJ80UIt4LvJj2eiUlILFIVd7eSuem9l17nt6zsRKF5tV9W4zxzQRYF0fomxFiraHXcUnVXCrJHhhL/lU/olYidaJYdzb5q05siSQz4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjTvH2SG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjTvH2SG"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c8f38febso35726595ad.2
        for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 21:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740114853; x=1740719653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2jjlr4QY6WmXNoKOLFDb3ZJQObW7F8NU0OkDiTkFJg=;
        b=bjTvH2SGtvtrnQCLcNrDioWmmk0aDIohEgRL2cuBk+4RfoywsxHh3NnOCCpgBs+DC9
         VqmB1jS4iZycHSHgk0BPrNW2ThLKZ4OVeWiIuSKpg06LGImG97IU2tPasE1OGLqLRYS7
         4MsU+AoyAZT+/awLXXb1SauHVgJErIs4klKfPJpyqRfqQ9YVK2v2R5V5PLsR4QrQ80DM
         ZnUXQSCdhDX+05HrmiEOS/zxtQs82TAyhpwQGowYZwBWMy9R5NHhzHtwR08oiuikCa9k
         M9uRI0O/9RSHJ2U9oLJkm+YAmVSLqC74KCGL9CNwCz/YTNhwyPt3DGnJv4Nm9ekeXhEc
         v5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740114853; x=1740719653;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w2jjlr4QY6WmXNoKOLFDb3ZJQObW7F8NU0OkDiTkFJg=;
        b=exUvuEoVWr0ILIGjFrnq6JRABL1EHDDOAg9nVukll2SJ+vXdJNMmrHc17r6WADnuie
         1qJMldsRLNuevzIr8JGACu9LheJ8VQCalPiceenb0/giI06kjv5pOuHGDpLoqxw7laxi
         WMw4/cNUuMR2ux2ioAstYYtxlgFXwQvuk/pM88Y9V8uwNBL0bMq3PWwOeCuKSjffRYcu
         mhqvz/Otvgq5puqVQ6vlPHUjS1BgyKCnqH+aNP2ImfTRh6CkNb8uI0EEuT85k1zn3TMO
         Npg3cwUiPh6h6JL3Gf80KC7BWn7m46FFOV8aPrM7YUmLhgRJfVwfQNkvb0ixWtxFiKGu
         4dig==
X-Forwarded-Encrypted: i=1; AJvYcCWL1y3d+GNB79u7saJ2/Zl+mZgmxZ9G2M4V+Tnx72EgbEFmUVJpdXQxhf1YPWGvJTj6IQyu5pjk@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqyv+zdTlX8Ft9ogzj/WH1tNrjwwn0vjXHbBkbRAD8bCH/BPXr
	Cp9pxhueEH/q+D5EwOa5JT1CjSGSeKqNPsOijFh4OvZbsevJjjYlf48zJQ==
X-Gm-Gg: ASbGncuFnhIGy30Ypesu85lEcv/XPgeCqrBLvitF2Hpv7fLWmLxbjLqTCnJliY9ghJc
	i62/5nXzwsX7Fkm4g5zO02HtjM0719aNuoFGOzkD9vTp+OfkTeERQpHxCIq9XnGO3qXSGXoXHMg
	oCjnLMnJvNUmLBmAGQmK7uEXGA0KS1DOdVxpMHB1UX5v38OktdAsTO2tCmqh3tHWp7ELi/8+a0x
	J72cM4s/23seuC4mvB/ykzFJoUcESq7FcvWwwzvNmsHwx8h8HDwjU3Uera/wzq9uQPdlX9KMP4P
	tvue9S0EK1MaR9JonieU5F9OshqSZPbLZGyXjV3xVqHv1YiVPBlcRgkvk3MkDWtrjthFcRsjL3t
	wjOs=
X-Google-Smtp-Source: AGHT+IGDDnUdKFDn6lncFqCmikBL5+lTCxz7z1Ag+AT3oHyWTBb16tkvI2R9xaT5gdxakZjQJHBD9w==
X-Received: by 2002:a17:902:e94d:b0:21f:71b1:70d8 with SMTP id d9443c01a7336-221a0032976mr31238405ad.51.1740114853436;
        Thu, 20 Feb 2025 21:14:13 -0800 (PST)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d558fe3asm128374685ad.234.2025.02.20.21.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 21:14:13 -0800 (PST)
Message-ID: <30dfe4a2d18ec2ca29d303c1f8fc943688221d59.camel@gmail.com>
Subject: Re: [PATCH] generic: test zero-byte writes to new file
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Eric Sandeen <sandeen@redhat.com>, "fstests@vger.kernel.org"
	 <fstests@vger.kernel.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 21 Feb 2025 10:44:09 +0530
In-Reply-To: <b4d76883-e58b-4db3-b7e4-7ddeb5ec7f42@redhat.com>
References: <b4d76883-e58b-4db3-b7e4-7ddeb5ec7f42@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2025-02-13 at 12:06 -0600, Eric Sandeen wrote:
> A bug was recently fixed in exfat where attempting to do a zero-byte
> write would yield -EFAULT; test for that here.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/tests/generic/761 b/tests/generic/761
> new file mode 100755
> index 00000000..e933eb83
> --- /dev/null
> +++ b/tests/generic/761
> @@ -0,0 +1,28 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 761
> +#
> +# test zero-byte writes
> +#
> +# exfat had a regression where a zero-byte write to a file would
> +# yield -EfAULT. Should work on all filesystems - write should
> +# succeed and the zero-byte file should be created.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +[ "$FSTYP" = "exfat" ] && _fixed_by_kernel_commit dda0407a2026 \
> +	"exfat: short-circuit zero-byte writes in
> exfat_file_write_iter"
> +
> +# Modify as appropriate.
> +_require_test
> +
> +rm -f $TEST_DIR/testfile.$seq
> +$XFS_IO_PROG -f -c "pwrite 0 0" $TEST_DIR/testfile.$seq
> +test -f $TEST_DIR/testfile.$seq || _fail "file not created"
Minor: Maybe just remove the test file that is created above (since we
are using the TEST_DIR)and not leave any test artifacts? Or, maybe use
the scratch device? 
--NR
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/761.out b/tests/generic/761.out
> new file mode 100644
> index 00000000..72ebba4c
> --- /dev/null
> +++ b/tests/generic/761.out
> @@ -0,0 +1,2 @@
> +QA output created by 761
> +Silence is golden
> 

