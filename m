Received: from mx1.redhat.com ([209.132.183.28]:56031 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348AbcGSKb5 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 19 Jul 2016 06:31:57 -0400
Date: Tue, 19 Jul 2016 18:31:54 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: Fwd: xfstests: error: redefinition of 'struct fsxattr'
Message-ID: <20160719103154.GQ27776@eguan.usersys.redhat.com>
References: <CADxRZqxz7XJ43i_Mn8kdnP7KPR2sK1wK5T2B-QAYj9_jCqUbCg@mail.gmail.com>
 <CADxRZqym3LQa0czmO0Ni5+qQ6R=U7s_7A7H9YWDeVcz8UtGqrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxRZqym3LQa0czmO0Ni5+qQ6R=U7s_7A7H9YWDeVcz8UtGqrg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Anatoly Pugachev <matorola@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 19, 2016 at 01:24:53PM +0300, Anatoly Pugachev wrote:
> Hello!
> 
> Can someone help me to compile xfstests taken from
> git://oss.sgi.com/xfs/cmds/xfstests

This should have been fixed in latest xfstests. Does your tree contain
commit ca7c8bcbe851 ("build: avoid struct fsxattr redefinition")?

Thanks,
Eryu
