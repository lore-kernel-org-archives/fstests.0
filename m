Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5FD78F44
	for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746004626; cv=none; b=IBXYjsu96lQA45WLW5IeS6VoJVFomvLvfueXrquen/U//ylmNQ0de0QpgGLlJCJj8fuQrsCIhhznHTnNhNcg61bHis+dq6THfP001b6bpdBmBiVw6IbhANK4ps1w1WqbfobHvo0F4JHIrZeL1GzswdvdmTdEPndGMBhvfPUiSS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746004626; c=relaxed/simple;
	bh=TviIf7Eh+XquJszXj7RnSC4af6OOK8FYtsnxa/KBWjU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=MrSZrLo/U50xIgVvp6goWZCoGF4p3upCbmSrGTH64drPmdMJKv/Lr8MIEVUsF+nM7AWHTSl2lKCZ0zxPNM5x2BjJQEKEoBiAx3le83p0FZtf0LIu7pcDP+rO1KWw7hkjSFrSTg3LJq8jn6RsOlIQQ4+KeyuaI5XqlU0fxIHn5NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9pb0r9K; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9pb0r9K"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736c1138ae5so7162184b3a.3
        for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 02:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746004624; x=1746609424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ft+edlQ3al0MG4OrOqxwHyW7Szb9ajqakrFYl8p7hvA=;
        b=Z9pb0r9KG4CCb0QYQpyRVIqo4dFMxRv+6cwOXX9g/QnccZBfGxDNNIvoaaEcm+cw4D
         4n7iw1lA/ObUHKLVNbKTbfskhczPEO6w8LhthfprsmPLbJYtzxpZW52UpywUCPhd0+N9
         m2TzWWQ2MrUlkIcBti040QVwrgf7krnZtJBYcU7ddY4YgdiEnXskXAs5mdK0Vwt28ELO
         d2aoSXu4BoYC8I5gXkuAmNvOwuJhXohoSSNUrj5DsdUOSKQQ5GJW6sykKGG6oUOAwPll
         56LCpxK4ZzjEzic5WaWde56IHBUhv8hkHP7bhTEZ7VFCIaooNkZeHS8Gu/5jq5GMJLcE
         2Wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746004624; x=1746609424;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ft+edlQ3al0MG4OrOqxwHyW7Szb9ajqakrFYl8p7hvA=;
        b=CcmZKtii+gpV7tQmP6nkWqnr4ngm6MBYJMhn679EvAXwcESUXkLwgKgh+YqxNGd2hU
         p+ROfia62Ys+9STnCc+8DSkdfuXwmvWYr3kMsOgfBcX0AgNUjjUZDNnP29WcoPuLObM5
         JkBEZeoC6+1Fhm2X3z/UjEvhRwrvQfp9gxpid0hAAHZHEqJOgeRfveKM2SFEQxfy/Ql0
         4MDmOG5Ox8HCZ4NFMStzjGlEownGkPkvUkJ0Kg2tRGtJ63aiTdhd/ajsXmVZBkT8BBXC
         Rzoh+8kdZc5Y9k6k+8SlNLhH4sdxFDjiw2G5AZARbfT7ID5d2B51bQH2KfekokmDHHQ5
         QIZw==
X-Forwarded-Encrypted: i=1; AJvYcCUJcBIamAuUEVy2M5lNmeRY2aCchmC7LW6ykqNtpc4nBEPgHTTGTJGzfb2cG+6FtRpIN2akO0bw@vger.kernel.org
X-Gm-Message-State: AOJu0YyKscDzCt4OgAv1iIDS0vO/9b/MJIbUQfBjfKPWiK7XQ+uD+puW
	p8NRjj/O1kx5qccUU+V+luIXGUKEp8SliQhBJlT6uYCGVtxu2zOiAQBCtQ==
X-Gm-Gg: ASbGncv+Mjz+5C18byiYbc8WNVTr0Hn2F+u5/z/r0+YH8X5S5cZ0XDik/wonOUtDhYx
	FITtdgyyztr/vuh4eDIjYLVj/1Pov8Ouk581YPFtWCHZZDkBzatSnpYpqSwt/y41beMYSv7hu9m
	fe1Fi0YJZMSgtzaeN33MkxPAsFoiiDE/hewBogikyMnXfbhv/eXSOo8IEVdyurDPPN5KfNO1DgY
	VlpTGaI7mIvvTSPSUt//q/5jWf48mMYVzcJ5IicagP3XvkYH+z7xX9s6Q4bg5tmE0jX2dAKj5zX
	hwPsWdqCXjopRjZaOsBfi1HdBAsv7SgjKphYlvPOGd19lDy+q1Lf8ddYYadRgXlSKq3k0Lr/Hv1
	qYlYBzjVNyLPFn0/woQ==
X-Google-Smtp-Source: AGHT+IHZUdhHlx8Gz5N6FX5SVtut2Edcr6AqRZKVGduMU/rEt8PRd4WW63fiD50fzOOwaM6FEXwMzg==
X-Received: by 2002:a05:6a21:1788:b0:1f5:837b:1868 with SMTP id adf61e73a8af0-20aa4380499mr3121411637.29.1746004624062;
        Wed, 30 Apr 2025 02:17:04 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15faded690sm10370480a12.71.2025.04.30.02.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:17:03 -0700 (PDT)
Message-ID: <0b040e1d9f7157614067850ca662ee47f68872ca.camel@gmail.com>
Subject: Re: [PATCH 01/28] fstests: remove support for non-numeric test names
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Wed, 30 Apr 2025 14:47:00 +0530
In-Reply-To: <20250417031208.1852171-2-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-2-david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> We haven't had any tests using the "999-the-mark-of-fstests" name
> format for a long time. Th eonly test that used this format was
> xfs/191-input-validation, and that got removed in 2022 by commit
> c1941d6f5 ("xfs/191: remove broken test").
> 
> However, the infrastructure for this naming convention still exists,
> so lets get rid of that dead code so we don't have to carry it
> anymore.
Any other reason why we are planning to remove this convention apart
from the fact that it is not being used for a long time? But yes,I
agree that only numeric names are easier to refer and we can also use
some one liner shell script tricks to run several tests - something
like 
./check xfs/{1...100} to run all the tests from xfs/1 xfs/2 ... xfs/100
(ofcourse assuming all these tests with these numbers exist).
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  check             | 15 ---------------
>  common/test_names |  8 +-------
>  new               | 24 ------------------------
>  3 files changed, 1 insertion(+), 46 deletions(-)
> 
> diff --git a/check b/check
> index 9451c350b..d6bab8b5f 100755
> --- a/check
> +++ b/check
> @@ -856,21 +856,6 @@ function run_section()
>  	for ((ix = 0; ix < ${#_list[*]}; !${#loop_status[*]} && ix++));
> do
>  		seq="${_list[$ix]}"
>  
> -		if [ ! -f $seq ]; then
> -			# Try to get full name in case the user
> supplied only
> -			# seq id and the test has a name. A bit of
> hassle to
> -			# find really the test and not its sample
> output or
> -			# helping files.
> -			bname=$(basename $seq)
> -			full_seq=$(find $(dirname $seq) -name $bname*
> -executable |
> -				awk '(NR == 1 || length <
> length(shortest)) { shortest = $0 }\
> -				     END { print shortest }')
> -			if [ -f $full_seq ] && \
> -			   [ x$(echo $bname | grep -o
> "^$VALID_TEST_ID") != x ]; then
> -				seq=$full_seq
> -			fi
> -		fi
> -
>  		# the filename for the test and the name output are
> different.
>  		# we don't include the tests/ directory in the name
> output.
>  		export seqnum=${seq#$SRC_DIR/}
> diff --git a/common/test_names b/common/test_names
> index 98af40cdb..b18fc9e36 100644
> --- a/common/test_names
> +++ b/common/test_names
> @@ -2,11 +2,5 @@
>  
>  # Valid test names start with 3 digits "NNN":
>  #  "[0-9]\{3\}"
> -# followed by an optional "-":
> -#  "-\?"
> -# followed by an optional combination of alphanumeric and "-" chars:
> -#  "[[:alnum:]-]*"
> -# e.g. 999-the-mark-of-fstests
> -#
>  VALID_TEST_ID="[0-9]\{3\}"
> -VALID_TEST_NAME="$VALID_TEST_ID-\?[[:alnum:]-]*"
> +VALID_TEST_NAME="$VALID_TEST_ID"
> diff --git a/new b/new
> index 6b50ffeda..c786a9dbb 100755
> --- a/new
> +++ b/new
> @@ -50,30 +50,6 @@ export AWK_PROG="$(type -P awk)"
>  echo "Next test id is $id"
>  shift
>  
> -read -p "Append a name to the ID? Test name will be $id-\$name.
> y,[n]: " -r
> -if [[ $REPLY = [Yy] ]]; then
> -	# get the new name from user
> -	name=""
> -	while [ "$name" = "" ]; do
> -		read -p "Enter the name: "
> -		if [ "$REPLY" = "" ]; then
> -			echo "For canceling, use ctrl+c."
> -		elif echo "$id-$REPLY" | grep -q "^$VALID_TEST_NAME$";
> then
> -			if [ -e "$tdir/$id-$REPLY" ]; then
> -				echo "File '$id-$REPLY' already exists,
> use another one."
> -				echo
> -			else
> -				name="$REPLY"
> -			fi
> -		else
> -			echo "A name can contain only alphanumeric
> symbols and dash!"
> -			echo
> -		fi
> -	done
> -
> -	id="$id-$name"
> -fi
> -
>  echo "Creating test file '$id'"
>  
>  if [ -f $tdir/$id ]

