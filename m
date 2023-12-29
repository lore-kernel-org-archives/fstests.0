Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DBA8488
	for <fstests@vger.kernel.org>; Fri, 29 Dec 2023 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="kwOhi2yJ"
Received: from cwcc.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3BT7gC2K032638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Dec 2023 02:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1703835734; bh=PD3XlWINkU5KWh4OY4ohmgodqGNDk2g9pYGLJC4D5/w=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=kwOhi2yJJIuVU/FB0Ia/tktRPVLUfhrIUbYOKF9lJt6g9AnUgNdkfnlWGJf/SrW7a
	 UzxTEnic1CLkfL4OhDcynshb+uxAqM1mFW76gGJKQIjyWW+rzkvLYWM031u40vXnSO
	 WlT7ycbxWkFkVscnZVK6jNehMB5zvf4RBTN6nPK7gG/yc9p7b7aO4QUXHyEMvFN5jN
	 k/yCGwdqj6cFO/TbteSdyLT0PkoIxHexIYOHh9U7oj98P9xlTYd0Yno1XZlefaIbu9
	 RJufaiEeCpwZdtd3+9PWQAFDp1paThMLJonJJObsC1S2DgNBOvgYCL7CnVDTvv7V1v
	 s448j60PLOFsg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3815B340545; Fri, 29 Dec 2023 01:42:12 -0600 (CST)
Date: Fri, 29 Dec 2023 01:42:12 -0600
From: "Theodore Ts'o" <tytso@mit.edu>
To: fstests@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        Leah Rumancik <leah.rumancik@gmail.com>
Subject: I got xfstests working on Mac OS!
Message-ID: <20231229074212.GA116263@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Well, technically I taught kvm-xfstests how to use qemu to use MacOS's
Hypervisor Virtualization Framework (hvf) --- hvf is MacOS / Apple
Silicon's analogue to kvm on x86_64 --- to boot an arm64 Linux kernel,
and I'm using the arm64 test appliance that had been created to run on
Google Compute Engine's arm platforms to run xfstests on a Macbook Air
M2.

The arm64 kernel was built using the "install-kconfig ; kbuild"
commands which are shipped with xfstests-bld[1], and the same kernel
can be used for arn64 GCE VM's in the cloud.  For now the kernel was
built in a Parallels VM running Debian Testing, although there are
some hacks[2] to allow you to build a Linux kernel using Apple's XCode
compilers without needing to boot up a Parallels VM.  I haven't had
time to play with that yet, though.

[1] https://github.com/tytso/xfstests-bld
[2] https://github.com/GayPizzaSpecifications/mac-linux-kdk

A quick demo video of this all working can be found here[3], and all
of the changes have been checked in and are available at [1].

[3] https://www.youtube.com/watch?v=JF_bcOCf_5Y

						- Ted

P.S.  Note: the current version of gcc-13 shipping with Debian
testing as of this writing will core dump while building one of the
kernel files (with host=aarch64 and target=aarch64) from v6.7-rc5.
This appears to be a compiler bug in gcc; Clang works just fine
building the arm64 test kernel which I used for this demo.

P.P.S.  Yes, "kvm-xfstests" is more and more of a misnomer these days;
the script can also be called as "qemu-xfstests", but I find
"kvm-xfstests" easier to type.  :-)

P.P.P.S.  No, I haven't tried using Asahi Linux on my Macbook Air M2
15" yet --- it's on my todo list to play with --- but it should work
just fine there.  There may be some minor changes needed to the
scripts in kvm-xfstests so that it works on a Fedora userspace, since
I do all of my development using Debian.  It should mostly work, as I
did fixed up issues so that kvm-xfstests would work on Fedora/x86_64 a
few months ago.  Some things may have bit rotted though, and I only
got the ability to run the test appliance working on Fedora; building
an updated Test Appliance doesn't yet work, since it would require
getting debootstrap to work on Fedora.  Patches welcome...
