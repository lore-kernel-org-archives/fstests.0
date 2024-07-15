Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5123AC0D
	for <fstests@vger.kernel.org>; Mon, 15 Jul 2024 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721058304; cv=none; b=mVnMmyog5Ku2ftHAOt3Ga2A1l1GhWlgopRReTD0tcdhQzE3satB/RtikifxwkBUc3OusDI57MdbR03YYyS5RKuRZs5F7YnuMFuNh/Cw+Y2S5YiQ6uun746UbmU9769ZSKHcY8B5hdYJTZd5sj8+9FhyNyXEel1a6cR0OAX9oBTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721058304; c=relaxed/simple;
	bh=uVVg83koxuTxHlI3Gdhe1hiSmyIb0BA6rMMNz58SzUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzDHfT5aWEh61MGu8GWq28DzZeusjIlITXXK4DhJkvvGnM7rQ7bdTdEKBMcFagFj6hOvOWXrzSqDzJbMs5ioZdavMLB0wbBysOGx/pg82qyWBoCm+0o9MhxP9BGqPVeyBlWBs6CwjVOIn0/apv/P5f6Y3mX+mqTdH7ITLbLuM3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=iZjNRjFQ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="iZjNRjFQ"
Received: from cwcc.thunk.org (pool-173-48-102-108.bstnma.fios.verizon.net [173.48.102.108])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46FFiset025922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 11:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1721058295; bh=yg69a71FCtqvIx9A58CR3L87MajB4AtbfPtI+CUam6w=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=iZjNRjFQ3BCmy20i4/lQcxETtKKWk6zlUpqf+He65TQ6mgp2F7t8gs4sNurzPe7oc
	 hoBsRNgEVwFiN4T3Nsc0CtyU+piYl7+pVEZP7hIiWGch6bEzYKANbFEeH6ZV67fBQJ
	 t6cu4ob2LGs+FcL0DKsWaWGJ3SRy3t/uSEfINKiRlsbPScqasGVSvTV9ERo0u0YexT
	 r5mKEmGei42SIoFv8l6P13HjnUmaGiwYEAE6cTB+COGo9O7KL2fatS7v2uLbcVGdVR
	 J/oaqthgZ5j8PdoBNy7KQQMxAjbNvW67kuwTY8D53bMiUGQh/PfxfRFuBH54VfFGcf
	 IXTaoZIMELdoA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 496ED15C029B; Mon, 15 Jul 2024 11:44:54 -0400 (EDT)
Date: Mon, 15 Jul 2024 11:44:54 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2024.07.14
Message-ID: <20240715154454.GB70013@mit.edu>
References: <64ec6187145dfd111f22f1ae151ae538@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64ec6187145dfd111f22f1ae151ae538@kernel.org>

On Sun, Jul 14, 2024 at 10:00:37PM +0800, Zorro Lang wrote:
> 2. Most of cases have removed '_supported_fs' line. From now on, if you don't
>    need a specific white or black fs list for a case, don't need _supported_fs
>    line.

A side effect of this change was that it triggered a failure in my GCE
test-appliance's regression test suite.  That's because one of the
things the regression tests run is: 

	gce-xfstests -c ext4/4k,btrfs/4k btrfs/001 generic/001 generic/002

and previously, when testing the ext4/4k configuration, btrfs/001
would be skipped due to its "_supported_fs btrfs" line.  Now, the test
is actually run, and it fails (unsurprisingly).

I'm going to work around this in my test appliance, so I'm not asking
that the change be reverted, but I thought I would point out that this
does result in a behavioural change in some corner cases.

       	    		       	       	      - Ted

commit 71b003b9ad0a0f0e4bf91619702addd0bb552f7d
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Mon Jul 15 11:34:30 2024 -0400

    test-appliance: exclude tests that are not supported for the file system type
    
    This is needed due to upstream xfstests commit f2c179ef055d ("remove
    spurious _supported_fs calls").
    
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/test-appliance/files/root/runtests.sh b/test-appliance/files/root/runtests.sh
index f59305b0..817d51f2 100755
--- a/test-appliance/files/root/runtests.sh
+++ b/test-appliance/files/root/runtests.sh
@@ -386,6 +386,14 @@ do
 	    AEX="$AEX -E /tmp/exclude-tests"
 	fi
 	if test ! -f "$RESULT_BASE/tests-to-run" ; then
+	    case "$BASE_FSTYPE" in
+		ext2|ext3|ext4)
+		    tests_regexp="ext4"
+		    ;;
+		*)
+		    tests_regexp="$BASE_FSTYPE"
+	    esac
+	    tests_regexp="^($tests_regexp|shared|generic|perf|selftest)"
 	    bash ./check -n $FSTESTSET >& /tmp/tests-to-run.debug
 	    ret="$?"
 	    echo "Exit status $ret" >> /tmp/tests-to-run.debug
@@ -396,6 +404,7 @@ do
 	    fi
 	    bash ./check -n $FSTESTSET 2> /dev/null | \
 		sed -e '1,/^$/d' -e '/^$/d' | \
+		grep -E "$tests_regexp" | \
 		sort > "$RESULT_BASE/tests-to-run"
 	    nr_tests=$(wc -l < "$RESULT_BASE/tests-to-run")
 	    if test "$nr_tests" -ne 1
