Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303E87207C
	for <fstests@vger.kernel.org>; Mon, 18 Dec 2023 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwM638kP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6AC7C433C8;
	Mon, 18 Dec 2023 17:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702921509;
	bh=2ZY7yoMl7VWJZ2ZVQqKlPYCOIIXqO2aQhKP8K2cpftE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwM638kPNBnlUcuyhTRSoY0ZA/ETtEQ95niZD/vggvw9AG4Owk+lrJkSST3Qwkec2
	 c/vffvp1xATB2v8CkIfEZlEVifd+5FFftopKTY+aKOq+3zBPMrQ2lDIpf+5zsc65nM
	 KQPnd/xdunjTWRmyMtiMUXj/6uenDueaULlF94dCpp5WJ/6t/o5ZeoQ5tc8j3DHzGI
	 fU9uWLtRmLeNqPLoD+P4fl3rNDky8NkbzcDaRykkAq3531o6YxPpMi3iReS5thlA57
	 IDsfTluSjU8K0d9ymyHOdohWATadgAsbPFGtU50RaMl147aQXi6o+LeGL4IzwaQz7l
	 vbzr8PnHoxT6w==
Date: Mon, 18 Dec 2023 09:45:09 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Alexander Patrakov <patrakov@gmail.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v2] _require_sparse_files: add a safeguard against media
 wearout
Message-ID: <20231218174509.GE36211@frogsfrogsfrogs>
References: <CAN_LGv2UUOZvxN6w83tLudPZ5O9VPN0aJVDJay4rJDsvtcn29Q@mail.gmail.com>
 <20231217210053.9180-1-patrakov@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217210053.9180-1-patrakov@gmail.com>

On Mon, Dec 18, 2023 at 05:00:53AM +0800, Alexander Patrakov wrote:
> _require_sparse_files is implemented as a list of filesystems known not to
> support sparse files, and therefore it misses some cases.
> 
> However, if sparse files do not work as expected during a test, the risk
> is that the test will write out to the disk all the zeros that would
> normally be unwritten. This amounts to at least 4 TB for the generic/129
> test, and therefore there is a significant media wearout concern here.
> 
> Adding more filesystems to the list of exclusions would not scale and
> would not work anyway because CIFS backed by SAMBA is safe, while CIFS
> backed by Windows Server 2022 is not.
> 
> In other words, Windows reserves the right to sometimes (!) ignore our
> intent to create a sparse file.
> 
> More discussion: https://lore.kernel.org/fstests/20231206184759.GA3964019@frogsfrogsfrogs/T/#t
> 
> Mitigate this risk by doing a small-scale test that reliably triggers
> Windows misbehavior and checking if the resulting file ends up being
> not sufficiently sparse.
> 
> Signed-off-by: Alexander Patrakov <patrakov@gmail.com>
> ---
>  common/rc | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index cc92fe06..5d27602a 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2871,6 +2871,12 @@ _require_fs_space()
>  # Check if the filesystem supports sparse files.
>  #
>  # Unfortunately there is no better way to do this than a manual black list.

FWIW if the truncate/write/nblocks check strategy below can be made more
general, then the comment above (and the FSTYP-filtering) become
unnecessary, right?

> +# However, letting tests expand all the holes and write terabytes of zeros to
> +# the media is also not acceptable due to wearout concerns.
> +#
> +# Note: even though CIFS supports sparse files, this test will mark it as
> +# failing the requirement if we can coax the server into allocating and writing
> +# the ranges where holes are expected. This happens with Windows servers.
>  #
>  _require_sparse_files()
>  {
> @@ -2881,6 +2887,23 @@ _require_sparse_files()
>      *)
>          ;;
>      esac
> +
> +    local testfile="$TEST_DIR/$$.sparsefiletest"
> +    rm -f "$testfile"
> +
> +    # A small-scale version of looptest - known to trigger Microsoft SMB server
> +    # into the decision to write zeros to the disk. Also creates a non-sparse file
> +    # on vfat.
> +    # See also the discussion at https://lore.kernel.org/fstests/20231206184759.GA3964019@frogsfrogsfrogs/T/#t
> +    $XFS_IO_PROG -f \
> +	-c 'truncate 0' -c 'pwrite -b 102400 -S 0x61 102400 102400' \
> +	-c 'truncate 0' -c 'pwrite -b 102400 -S 0x61 204800 102400' \
> +	-c 'truncate 0' -c 'pwrite -b 102400 -S 0x61 307200 102400' \
> +	-c 'truncate 0' -c 'pwrite -b 102400 -S 0x61 409600 102400' "$testfile" >/dev/null
> +    resulting_file_size_kb=$( du -sk "$testfile" | cut -f 1 )
> +    rm -f "$testfile"
> +    [ $resulting_file_size_kb -ge 300 ] && \

I might be missing something here because I've long forgotten how CIFS
and Windows work, but -- why is it necessary to truncate and write past
eof four times?  Won't the truncates free all the blocks associated with
the file?

Also, why isn't it sufficient to check that the du output doesn't exceed
~110K (adding 10% overhead)?

> +	_notrun "Sparse files do not work as expected, skipping test due to media wearout concerns"

I think the notrun message should be restricted to stating that sparse
files do not work as expected -- the other callers aren't necessarily
worried about wearout.

--D

>  }
>  
>  _require_debugfs()
> -- 
> 2.43.0
> 
> 
