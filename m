Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33545 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2407200AbfITXlW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 Sep 2019 19:41:22 -0400
Date: Fri, 20 Sep 2019 19:41:16 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH][xfstests-bld] build-all: fix acl tools build
Message-ID: <20190920234116.GB21006@mit.edu>
References: <20190920184846.18251-1-amir73il@gmail.com>
 <CAOQ4uxh9A287mMnNiikFvOwqVem=PJMsifGgmb5nLo1YdDNO6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh9A287mMnNiikFvOwqVem=PJMsifGgmb5nLo1YdDNO6g@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 20, 2019 at 09:51:18PM +0300, Amir Goldstein wrote:
> CC: Eryu's correct email address

You probably don't need to explicitly cc Eryu, since he's reviewing
xfstests-bld changes.

For that matter, if people are getting annoyed because there are too
many xfstests-bld/{kvm,gce,android}-xfstests changes getting sent to
fstests, please let me know and we can use some other list for these
reviews.

				- Ted
