Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD16B628
	for <fstests@vger.kernel.org>; Mon, 15 Jan 2024 02:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bfpEAQQM"
Received: from cwcc.thunk.org (pool-173-48-115-247.bstnma.fios.verizon.net [173.48.115.247])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40F2v7NA021497
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jan 2024 21:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1705287428; bh=zzWsEGxzDhIpoNhKyW4frvwLTk7wEvh7nSMTRvX4V0E=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=bfpEAQQMCW6f8Ce4fGZKdjJPUBqfvaJX2uv9ZjnkkLqVk6WnNgEiUJo/xzIA6ynuk
	 2BDqv0DGoCZ5FOp9zbiV4hHt/M00PNWneGzWLoDf0X66yx2cuBb7dhBf6FbReVdgOw
	 4aVj5fsNdi6reozgMZgBAN1ntmP6uKaZPIPVE/b34cRIM5CUi5eOVaq26YI6O77SEU
	 bIGDpG3rzR9tGGzb3jMf4KU8luRTgghifgZvC+df7epG3v5poFFb2nMc/dLUtkYzwO
	 fCT5lJbaNSo/w2BBvpPSF2UVlovxbqCr9RONRkh6+jxo1jR0gMPX79qqsJPzfzCQcR
	 swQi9Yz2htGXA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E967015C0278; Sun, 14 Jan 2024 21:57:06 -0500 (EST)
Date: Sun, 14 Jan 2024 21:57:06 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Richard Weinberger <richard@nod.at>
Cc: fstests@vger.kernel.org
Subject: Re: fsgqa group membership?
Message-ID: <20240115025706.GF911245@mit.edu>
References: <1998649210.233983.1705246961955.JavaMail.zimbra@nod.at>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1998649210.233983.1705246961955.JavaMail.zimbra@nod.at>

On Sun, Jan 14, 2024 at 04:42:41PM +0100, Richard Weinberger wrote:
> It turned out that the test failed because the user "fsgqa" did not
> have the "fsgqa" group assigned.  After rectifying this, the test
> passed successfully.
> 
> But it is nowhere stated that this has to be that way.
> 
> README says only:
> 6. (optional) Create fsgqa test users and groups:
> 
>    $ sudo useradd -m fsgqa
>    $ sudo useradd 123456-fsgqa
>    $ sudo useradd fsgqa2
>    $ sudo groupadd fsgqa

The useradd program creates the /etc/passwd entry as well as the
/etc/group entry.  Demonstration:

% kvm-xfstests shell
    ...
root@kvm-xfstests:~# grep foobarbaz /etc/passwd
root@kvm-xfstests:~# grep foobarbaz /etc/group
root@kvm-xfstests:~# useradd foobarbaz
root@kvm-xfstests:~# grep foobarbaz /etc/passwd
foobarbaz:x:31418:31418::/home/foobarbaz:/bin/sh
root@kvm-xfstests:~# grep foobarbaz /etc/group
foobarbaz:x:31418:

I don't know why that "sudo groupadd fsgqa" is in the README; it's not
necessary, and it would cause a "group already exists" error message.
For example:

root@kvm-xfstests:~# groupadd foobarbaz
groupadd: group 'foobarbaz' already exists

I did this demonstration using on a Debian-based test appliance.  But
it looks like Fedora's "useradd" works exactly the same way.  See the
web page here:

https://docs.fedoraproject.org/en-US/fedora/latest/system-administrators-guide/basic-system-configuration/Managing_Users_and_Groups/

						- Ted
