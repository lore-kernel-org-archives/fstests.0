Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C0428F5
	for <fstests@vger.kernel.org>; Sun, 30 Aug 2026 23:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788131656; cv=none; b=qWT//Rruzp5tlYz+iemBI/71V/OioV142FUiUE7MBNYulNf3VjLCP6YH2MGJDfMRd9qsVNDRjjhfY5YQ/ZiUprxKTC29LD40PxN2oAl2tYICqO6zelm8c1220uQ4LF/WK/1zzFX0KJcra2oH7pNjMHt0JU2LpFjHrHF6pR5SpDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788131656; c=relaxed/simple;
	bh=sWvWi63qnqXkLg50mfl2yCmFZbSL0c2QQUd+d3IJwsg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SiysYfINXqW9OgWiQ8PdUJ1Siw3dA/0nxq17Te09Wrc6hZmbMNtAD/WwreyCYhBy1s8OE8zneTPAcSRUdHRk+bDKnCt6YIRnV9g2T9OILwajqttL8ymjZpnGql5wv36SHxDLUVAxfnAict5nbdDplWr0BFB4hmeO+EWPhGb0Ww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6KRi7rP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6KRi7rP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6CB1F00A3D
	for <fstests@vger.kernel.org>; Sun, 30 Aug 2026 23:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788131654;
	bh=5iHkvC7WHRmbVtiMjSDUBc8+v7BhLkSXGXSdVc+gbls=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=T6KRi7rPp1hLp1Gy5KYtBdz03pqZrdrXumOTfw/BVUkS5iFfzh2+F6V8T6UKeHfxt
	 nm0rmCLWzK4v0pvNrbkiO/Fyij6S8uZSyVcDIFeiLhgyqC5d3gaLgewGViAe9OcfLo
	 Jn9CM2IXmXM1ZRtPHme0ybwMPFCvRlsx80pcDpSR1mV/eS8WW9sQ2IJ7BSInXiyyoS
	 yPjD5FZq202gNU7GVYnD0QLr/yYKtnekConOEqqcfGTGboxCLZoolSvOd8RFMqE5h+
	 u1joSpIhagn3UVhjqD3HZNQ//1WYGRjHWp6ruW3KZGLpKNmp44RG7/bAkrJGqgcRbL
	 WpMBcZ8j0RwWw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B6CB1F40066;
	Sun, 30 Aug 2026 19:14:13 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sun, 30 Aug 2026 19:14:13 -0400
X-ME-Sender: <xms:RbmUalX3kqybJy2eNJtg4Imn8wJIfEG5443PSHqSI5TAPXLq4Rw9TQ>
    <xme:RbmUagaBtBgrXCOroZLCzcK1O6hKoGZumaOyY7eHo1la4qSoPKVwiyHNKO13-g2cE
    NDkCIK7XOM86M8Owww0ACO0Kl4QpX5q5AYIJkR1OCDPB5t4q9YYN9GU>
X-ME-Proxy-Cause: dmFkZTGaOChUc6KWp7f+rm4x3fk8MUoGXRUsVZwFOddJL4G2SGkk57/+6CZGb/HaUzkBph
    194BxJatuO0SqZ3CE1cPBoPkGPayKct12Tvz4eZF0iHLLrto6H39wJmymOh5IgiXj1jbBa
    UoCFjDcQy6XpBm2S/hQXAZX+NJRlWgF/dpHQEso1yOImHY6v15irNMPjVOYfl3DiojvQev
    XccDqwd08dllRYeDECQPgeor5yVIgFgwRvJ02o/9GkflazUYCzHVeGpRpjc3pAgk9eEj0T
    OhwKSxdGPxO57T/KK4QwM/Cd4J8ob5sSolx0a6epul4WnhwGCLRTURarGSm38h27as9jdC
    hEISh7+gqmBAdv5Jjl/AhEUjhGNoQgkdXOStkKYC8qTu2xKmtjKdUZiCSywnODyXgE0S9F
    IKE+EJe3eI9Sbr1mwLX3FRru/BUaNMmncWlCwafuDrXt8XRownpAlLuDBbKgMIlPBkumop
    UcWj44L6ub3F+VnoXcPwfLUQHUgI6vaXqvDhW/fC9jducK5JACmNZrjPnA1SIX0mj0FeSN
    QNam/eDP9areeJWBno4EDr04Jj4RqDCVIymjGezbgdoG1Z9fwsp0wsxsveL1fsq9uNuX9K
    DJLUyXxpEO4T6L5kAEAJetx67YOSZgCxB+pRZCvsZLWP/xJU4R8FTWRMm8cQ
X-ME-Proxy: <xmx:RbmUak7ziDj4SJiJ3ANK3tNSkHvhjpav6TCba1pyG785wgIV7nzHEQ>
    <xmx:RbmUamAtYRdSgKTE8d8Ovg2FwjDbktdv1KfFMQ3R8IqsakFCInL4Rw>
    <xmx:RbmUarabd8WTKOnX9KPRwUYiQQmD7feOGxI8umBSVp3vUQODmC4Yhg>
    <xmx:RbmUahaRyUwGcJXQn3sVOBlWapfndjpmFereh6j3-v5zK9ajVx7IYA>
    <xmx:RbmUai-YXgyDRzDHs9eCwckqBXehkKreSoSZAub6m3Y02lFKmhqyHgwl>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8A9B77811F0; Sun, 30 Aug 2026 19:14:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AflgjeobGf1w
Date: Sun, 30 Aug 2026 19:13:56 -0400
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>, fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Message-Id: <114f727b-86bc-40b8-8487-35bccf101d2c@app.fastmail.com>
In-Reply-To: <20260827234743.2389778-2-neilb@ownmail.net>
References: <20260827234743.2389778-1-neilb@ownmail.net>
 <20260827234743.2389778-2-neilb@ownmail.net>
Subject: Re: [PATCH] fstests: generic: Add test of seek in directories
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Thu, Aug 27, 2026, at 7:36 PM, NeilBrown wrote:
> Add a test for consistency of readdir (getdents64) results.

Thanks for writing this!

Note that it asserts more than exactly-once: the relative order of
every stable name must hold for the life of the directory, across
independent opens. That is the right property needed for NFS. Either
the internal documentation or the commit message should say that,
and explain why: between two READDIRs there is no open state, so the
server can be handed any cookie against any later state of the
directory. POSIX does not require this, certainly, but NFS does. 

The seek check picks n from all names, including unstable ones
unlinked many loops earlier, using the d_off from the first scan.
That is the "rm -rf over NFS" case and the most valuable check here,
but it reads like an oversight. Can you add a comment saying it is
deliberate?

The seven op classes run mixed in one invocation, so a failure says
"loop 37 with seed 1234567" and not which *semantic* broke. btrfs
fails only on renames onto a stable name, and nobody can tell that
from the output without rerunning with -T. It might be nicer to have
the wrapper invoke the binary once per class, or at least once each
for churn, rename onto an existing name, and RENAME_EXCHANGE. Then
put exchange in its own test gated by _require_renameat2 exchange,
which replaces the FSTYP == nfs check and _notruns everywhere the
flag is unsupported.

> +_begin_fstest auto dir quick

Add rename, perhaps?

> +$here/src/t_dir_seek -p $TEST_DIR -S 1234567 $extra

$TEST_DIR/testdir is not scoped to $seq and there is no _cleanup().
A run interrupted before clean_files() makes the next one fail in
mkdir with exit status 1. Use $TEST_DIR/$seq-dir and rm -rf it before
the run and in _cleanup().

> +		case op_create:
> +			n = get_file(&unused);
> +			if (n > 0) {

n >= 0. Name 0 is a valid index. Drawn here it is removed from unused
and never put back anywhere.

> +	lseek(fd, off, SEEK_SET);

For both get_order() and check_order(), a rejected cookie should fail
with the errno, not proceed from 0 and report bad order.

Nits: copyright 2025 vs 2026; typos in both header comments; %lu for
uint64_t; usage says "-p 10" for -o; the -n and -o range errors name
the wrong flags; d_name[] rather than d_name[0].

With the wrapper and op_create fixes:

Reviewed-by: Chuck Lever <cel@kernel.org>

I will also note that, despite the new failures, users of NFS-
exported tmpfs and btrfs filesystems have not observed or reported
problems. So the severity of these failures is not high, IMO, but it
would still be good to correct them. It's great to see more of the
specific NFS requirements for directories materialized in a set of
unit tests.


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)
