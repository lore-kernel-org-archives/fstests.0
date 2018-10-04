Received: from imap.thunk.org ([74.207.234.97]:45566 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbeJDKJe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 Oct 2018 06:09:34 -0400
Date: Wed, 3 Oct 2018 23:18:23 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [xfstests-bld PATCH] kernel-configs: fix i386 configs
Message-ID: <20181004031823.GB646@thunk.org>
References: <20180907010118.234124-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20180907010118.234124-1-ebiggers@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@kernel.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 06, 2018 at 06:01:18PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Commit 452331adc6c0 ("kernel-configs: enable virtio_9P and 9P_FS")
> removed the explicit unsetting of CONFIG_64BIT from some of the i386
> kconfigs.  So, they actually became x86_64.  Fix it by syncing them back
> up with the x86_64 configs.  I also added the script I used to do this.

The explicit "CONFIG_64BIT is not set" is actually not necessary if
you specify ARCH=i386 in the make command --- and in the latest
kernel, using ARCH=i386 in the command line is actually required.
There was a discussion about this on LKML a few months.  I use an
explicit ARCH=i386 to build 32-bit kernels in my build scripts, since
it's needed for the latest kernels, and if you use ARCH=i386 in the
command line, "make savedefconfig" doesn't include the CONFIG_64BIT:

% kbuild32 savedefconfig
make[1]: Entering directory '/build/ext4-3.18'
  GEN     ./Makefile
scripts/kconfig/conf --savedefconfig=defconfig Kconfig
make[1]: Leaving directory '/build/ext4-3.18'

real    0m0.715s
user    0m0.492s
sys     0m0.251s
% grep CONFIG_64BIT /build/ext4-3.18/.config
# CONFIG_64BIT is not set
% grep -c CONFIG_64BIT /build/ext4-3.18/defconfig 
0

... where kbuild32 does:

time nice make O="$BLD_DIR_32" ARCH=i386 -j$N $*

As a result, your script isn't going to actually guarantee the
CONFIG_64BIT is explicitly unset in the defconfig.  (In fact, I have a
similar script, called "update-kernel-config" which is in the META
branch, and I used it to automate the generation of the defconfigs in
commit 452331adc6c0.  Check out the META branch if you're curious how
I do my automated build and release.)

Bottom line: depending on the explicit unset of CONFIG_64BIT won't
work on more modern kernels, so future build scripts will need to
explicitly use ARCH=i386 in the make command.  (I'll attach my kbuild
and kbuild32 scripts in case you are interested.)  Still, I don't mind
adding the explicit unsetting of CONFIG_64BIT to the kernel configs,
since they are harmless and they will work for the more modern
kernels.  But the kernel sync scripts will to explicitly add the
CONFIG_64BIT unset line if it's not there.

Cheers,

					- Ted

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kbuild32

#!/bin/bash

# N=$(($(getconf _NPROCESSORS_ONLN) / 2))
N=$(($(getconf _NPROCESSORS_ONLN) * 1))

mkdir -p .git/kbuild
if test -f .git/kbuild/config ; then
    . .git/kbuild/config
elif test -f .git/kbuild.conf ; then
    . .git/kbuild.conf
    mv .git/kbuild.conf .git/kbuild/config
else
    echo "Missing kbuild configuration file!"
    exit 1
fi

if test -z "$BLD_DIR_32" ; then
   echo "No BLD_DIR_32 directory"
   exit 1
fi

if test ! -d "$BLD_DIR_32" ; then
    mkdir -p "$BLD_DIR_32"
    if test -f .git/kbuild/kernel-config ; then
	cp .git/kbuild/kernel-config-32 "$BLD_DIR_32/.config"
    fi
    for i in x509.genkey signing_key.pem signing_key.x509
    do
	if test -f ".git/kbuild/$i" ; then
	    mkdir -p "$BLD_DIR_32/certs"
	    cp ".git/kbuild/$i" "$BLD_DIR_32/certs"
	fi
    done
fi

time nice make O="$BLD_DIR_32" ARCH=i386 -j$N $*

cp "$BLD_DIR_32/.config" .git/kbuild/kernel-config-32
for i in x509.genkey signing_key.pem signing_key.x509
do
    if test -f "$BLD_DIR_32/certs/$i" ; then
	    cp "$BLD_DIR_32/certs/$i" .git/kbuild
    fi
done

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kbuild

#!/bin/bash

# N=$(($(getconf _NPROCESSORS_ONLN) / 2))
N=$(($(getconf _NPROCESSORS_ONLN) * 1))

mkdir -p .git/kbuild
if test -f .git/kbuild/config ; then
    . .git/kbuild/config
elif test -f .git/kbuild.conf ; then
    . .git/kbuild.conf
    mv .git/kbuild.conf .git/kbuild/config
else
    echo "Missing kbuild configuration file!"
    exit 1
fi

if test ! -d "$BLD_DIR" ; then
    mkdir -p "$BLD_DIR"
    if test -f .git/kbuild/kernel-config ; then
	cp .git/kbuild/kernel-config "$BLD_DIR/.config"
    fi
    for i in x509.genkey signing_key.pem signing_key.x509
    do
	if test -f ".git/kbuild/$i" ; then
	    mkdir -p "$BLD_DIR/certs"
	    cp ".git/kbuild/$i" "$BLD_DIR/certs"
	fi
    done
fi

time nice make O="$BLD_DIR" ARCH=${KERN_ARCH:-x86_64} -j$N $*

cp "$BLD_DIR/.config" .git/kbuild/kernel-config
for i in x509.genkey signing_key.pem signing_key.x509
do
    if test -f "$BLD_DIR/certs/$i" ; then
	    cp "$BLD_DIR/certs/$i" .git/kbuild
    fi
done


--G4iJoqBmSsgzjUCe--
